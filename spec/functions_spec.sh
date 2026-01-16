#shellcheck shell=bash
Describe 'Tests for check functions.'
Include ./utils/lib-enhanced
# Include ./awesome
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

Describe 'Testing symlink_names().'
It 'outputs the my-link.'
When run symlink_names "$bin_dir"
The stdout should eq "my-link"
The status should eq 0
End
End

Describe 'Testing check_link().'
It 'outputs the status of 0.'
When run check_link "my-link" "$bin_dir"
The status should eq 0
End
End

Describe 'Testing src_path().'
myrealpath() {
  (
    OURPWD=$PWD
    cd "$(dirname "$1")" || exit
    LINK=$(readlink "$(basename "$1")")
    while [ "$LINK" ]; do
      cd "$(dirname "$LINK")" || exit
      LINK=$(readlink "$(basename "$1")")
    done
    REALPATH="$PWD/$(basename "$1")"
    cd "$OURPWD" || exit
    echo "$REALPATH"
  )
}
It 'outputs source path.'
When run src_path "$(myrealpath "$link")"
The stdout should eq "${awesome_dir}"
End
End
Describe 'Testing check_cmd()'
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
End
End
