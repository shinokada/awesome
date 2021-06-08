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
            The stdout should eq "You have $dir dir."
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

    Describe 'Testing check_link().'
        # filename=$(openssl rand -hex 4)
        # file="$HOME/awesome/$filename"
        # link="$HOME/bin/my-link"
        # setup() {
        #     touch "$file"
        #     ln -s "$file" "$link"
        # }
        # cleanup() {
        #     return
        #     # rm -rf "$file"
        #     # rm "$link"
        # }
        # It 'outputs the status of 0.'
        #     When run check_link "my-link" "$HOME/bin"
        #     The status should eq 0
        # End
    End
End
