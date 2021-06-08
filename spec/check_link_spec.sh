#shellcheck shell=sh

Describe 'Run check_link()'
    Include ./lib
    filename=$(openssl rand -base64 12)
    setup() {
        touch "$HOME/awesome/$filename"
        ln -s "$HOME/awesome/$filename" "$HOME/bin/$filename"
    }
    cleanup() {
        rm "$HOME/awesome/$filename"
        rm "$HOME/bin/$filename"
    }
    BeforeAll 'setup'
    AfterAll 'cleanup'
    It 'outputs  '
        When run check_link "$filename"
        The status should eq 0
    End

End
