#shellcheck shell=sh
# shellcheck disable=SC2154

Describe 'Run repo_script()'
    Include ./utils/lib-enhanced
    It 'outputs git_user, repo_name, script_name, repo_link with  full GitHub URL'
        When call repo_script shinokada/gitstart
        The value "$git_user" should eq 'shinokada'
        The value "$repo_name" should eq 'gitstart'
        The value "$script_name" should eq 'gitstart'
        The value "$repo_link" should eq 'https://github.com/shinokada/gitstart'
    End
    It 'outputs git_user, repo_name, script_name, repo_link with  full GitHub URL'
        When call repo_script https://github.com/shinokada/cleanit.git
        The value "$git_user" should eq 'shinokada'
        The value "$repo_name" should eq 'cleanit'
        The value "$script_name" should eq 'cleanit'
        The value "$repo_link" should eq 'https://github.com/shinokada/cleanit.git'
    End
    It 'outputs git_user, repo_name, script_name, repo_link with raylee/tldr-sh-client tldr'
        When call repo_script raylee/tldr-sh-client tldr
        The value "$git_user" should eq 'raylee'
        The value "$repo_name" should eq 'tldr-sh-client'
        The value "$script_name" should eq 'tldr'
        The value "$repo_link" should eq 'https://github.com/raylee/tldr-sh-client'
    End
    It 'outputs git_user, repo_name, script_name, repo_link with https://github.com/raylee/tldr-sh-client.git tldr '
        When call repo_script https://github.com/raylee/tldr-sh-client.git tldr
        The value "$git_user" should eq 'raylee'
        The value "$repo_name" should eq 'tldr-sh-client'
        The value "$script_name" should eq 'tldr'
        The value "$repo_link" should eq 'https://github.com/raylee/tldr-sh-client.git'
    End
    It 'outputs git_user, repo_name, script_name, repo_link with https://github.com/raylee/tldr-sh-client tldr'
        When call repo_script https://github.com/raylee/tldr-sh-client tldr
        The value "$git_user" should eq 'raylee'
        The value "$repo_name" should eq 'tldr-sh-client'
        The value "$script_name" should eq 'tldr'
        The value "$repo_link" should eq 'https://github.com/raylee/tldr-sh-client'
    End
    It 'outputs Please use URL or https, not ssh.'
        When run repo_script tldr
        The stderr should eq 'Not valid parameter.'
        The status should eq 1
    End
    It 'rejects SSH URLs with appropriate error message'
        When run repo_script git@github.com:shinokada/cleanit.git
        The stderr should eq 'Please use URL or https, not ssh.'
        The status should eq 1
    End
End
