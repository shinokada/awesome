#shellcheck shell=sh
Describe 'Tests for functions.'
    Include ./lib
    dirname=$(openssl rand -hex 6)
    dir="/tmp/$dirname"
    setup() {
        mkdir "$dir"
    }
    cleanup() {
        rm -rf "$dir"
        # since checkOrmkdir run mkdir $1, you need to remove from the script dir
        rm -rf "$dirname"
    }

    Describe 'Testing checkOrmkdir'
        It 'outputs the status of 1.'
            When run checkOrmkdir
            The stderr should eq "Specify the directory."
            The status should eq 1
        End

        Before 'setup'
        After 'cleanup'
        It 'outputs the status of 0.'
            When run checkOrmkdir "$dir"
            The status should eq 0
        End
    End

    Describe 'Testing checkDir function.'
        It 'outputs the status of 1.'
            When run checkDir
            The status should eq 1
        End

        Before 'setup'
        After 'cleanup'

        It 'outputs the status of 0.'
            When run checkDir "$dir"
            The status should eq 0
        End
    End

    Describe 'Tests for list and link'
        filename=$(openssl rand -hex 4)
        awesome_dir="/tmp/awesome"
        file="$awesome_dir/$filename"
        bin_dir="/tmp/bin"
        link="$bin_dir/my-link"
        setup() {
            mkdir "$awesome_dir"
            touch "$file"
            mkdir "$bin_dir"
            ln -s "$file" "$link"
        }
        cleanup() {
            rm -rf "$bin_dir"
            rm -rf "$awesome_dir"
        }
        BeforeAll 'setup'
        AfterAll 'cleanup'

        Describe 'Testing symlink_names.'
            It 'outputs the my-link.'
                When run symlink_names "$bin_dir"
                The stdout should eq "my-link"
                The status should eq 0
            End
        End

        Describe 'Testing no_symlink.'
            It 'outputs the status of 0.'
                When run no_symlink "no-link" "$bin_dir"
                The status should eq 0
            End
        End

        Describe 'Testing no_symlink.'
            It 'outputs the status of 1.'
                When run no_symlink "my-link" "$bin_dir"
                The status should eq 1
            End
        End

        Describe 'Testing src_path.'
            It 'outputs source path.'
                When run src_path "$(realpath "$link")"
                The stdout should eq "/private${awesome_dir}"
            End
        End

        Describe 'Testing check_cmd'
            It 'uses command -v  and outputs 0 or 1 depending a command exists or not'
                When run check_cmd cd
                The status should eq 0
            End
            It 'outputs 0 or 1 depending a command exists or not'
                When run check_cmd abcdefg
                The status should eq 1
                The stderr should eq "Please install abcdefg"
            End
        End
        Describe 'Testing checkFile.'
            It 'outputs file 0 if there is a file.'
                When run checkFile "dir/file"
                The status should eq 1
            End
        End

        Describe 'Testing checkFile.'
            It 'outputs file 0 if there is a file.'
                When run checkFile "$file"
                The status should eq 0
            End
        End

        Describe 'Testing num_symlinks.'
            It 'outputs 1 when there is a one symlink.'
                When run num_symlinks "$filename" "$bin_dir"
                The output should eq 1
            End
        End

    End

    Describe 'Testing slash_num'
        It 'outputs 0.'
            When run slashes "path"
            The stdout should eq "0"
        End
        It 'outputs 1.'
            When run slashes "path/dir"
            The stdout should eq "1"
        End
        It 'outputs 2.'
            When run slashes "path/to/dir"
            The stdout should eq "2"
        End
        It 'outputs 3.'
            When run slashes "path/to/sub/dir"
            The stdout should eq "3"
        End
    End

    Describe 'Testing first.'
        It 'outputs first part of a path.'
            When run first "dir/file"
            The stdout should eq "dir"
        End
    End
    Describe 'Testing second.'
        It 'outputs second part of a path.'
            When run second "dir/file"
            The stdout should eq "file"
        End
    End

    Describe 'Testing main_repo.'
        It 'outputs second part of a path.'
            When run main_repo "dir/file"
            The stdout should eq "file"
        End
    End

End
