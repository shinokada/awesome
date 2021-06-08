#shellcheck shell=sh
Describe 'Tests for check functions.'
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
    Describe 'Testing checkOrmkdir()'
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
            The stderr should eq "Ooops!  doesn't exist."
            The status should eq 1
        End

        Before 'setup'
        After 'cleanup'

        It 'outputs the status of 0.'
            When run checkDir "$dir"
            The status should eq 0
        End
    End

    Describe 'Testing fn_list().'
        # setup() {
        #     touch "$file"
        #     ln -s "$file" "$link"
        # }
        # cleanup() {
        #     return
        #     rm -rf "$file"
        #     rm "$link"
        # }
        # It 'outputs the status of 1.'
        #     When run fn_list "$dirname"
        #     The value "$repo_name" should eq 'gitstart'
        # End
    End

    Describe 'Testing check_link().'
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
            # rm "$link"
        }
        Before 'setup'
        After 'cleanup'
        It 'outputs the status of 0.'
            When run check_link "my-link" "$bin_dir"
            The status should eq 0
        End
    End
End
