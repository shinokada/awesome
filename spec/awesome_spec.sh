#shellcheck shell=sh

Describe 'run fn_repo_script()'
    Include ./lib
    It 'outputs git_user, repo_name, script_name, repo_link'
        When call fn_repo_script shinokada/gitstart
        The line 1 of output should eq 'shinokada gitstart gitstart https://github.com/shinokada/gitstart'
        #     The line 2 of output should eq 'tldr'
    End
    It 'outputs git_user, repo_name, script_name, repo_link'
        When call fn_repo_script raylee/tldr-sh-client tldr
        The line 1 of output should eq 'raylee tldr-sh-client tldr https://github.com/raylee/tldr-sh-client'
        #     The line 2 of output should eq 'tldr'
    End
End
