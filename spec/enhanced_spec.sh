#!/usr/bin/env bash
# Tests for enhanced awesome features

Describe 'Enhanced Awesome Functions'
  Include ./utils/lib
  
  setup() {
    TEST_DIR="$SHELLSPEC_TMPBASE/awesome-test"
    AWESOME_DIR="$TEST_DIR/awesome"
    BIN_DIR="$TEST_DIR/bin"
    LOG_DIR="$TEST_DIR/logs"
    
    mkdir -p "$AWESOME_DIR"
    mkdir -p "$BIN_DIR"
    mkdir -p "$LOG_DIR"
  }
  
  cleanup() {
    rm -rf "$TEST_DIR"
  }
  
  Before 'setup'
  After 'cleanup'

  Describe 'Configuration Loading'
    It 'loads default configuration'
      When call load_config
      The variable AWESOME_DIR should be defined
      The variable BIN_DIR should be defined
      The variable LOG_DIR should be defined
    End
  End

  Describe 'Logging Functions'
    It 'creates log directory'
      ENABLE_LOGGING=true
      When call init_logging
      The path "$LOG_DIR" should be directory
    End

    It 'writes log messages'
      ENABLE_LOGGING=true
      LOG_DIR="$TEST_DIR/logs"
      When call log_message "INFO" "test message"
      The file "$LOG_DIR/awesome.log" should be exist
    End

    It 'logs operations'
      ENABLE_LOGGING=true
      LOG_DIR="$TEST_DIR/logs"
      When call log_operation "install" "test-package" "success"
      The file "$LOG_DIR/awesome.log" should be exist
      The contents of file "$LOG_DIR/awesome.log" should include "install"
      The contents of file "$LOG_DIR/awesome.log" should include "test-package"
    End
  End

  Describe 'Network Functions'
    It 'checks network connectivity'
      # This test requires internet connection
      # Skip if offline
      if ping -c 1 github.com &>/dev/null; then
        When call check_network
        The status should be success
      else
        Skip "No internet connection"
      fi
    End
  End

  Describe 'Package Management'
    It 'creates package manifest'
      When call create_manifest "test-package" "https://github.com/test/repo" "v1.0.0"
      The file "$AWESOME_DIR/test-package/.awesome-manifest" should be exist
      The contents of file "$AWESOME_DIR/test-package/.awesome-manifest" should include "test-package"
      The contents of file "$AWESOME_DIR/test-package/.awesome-manifest" should include "v1.0.0"
    End

    It 'reads package manifest'
      mkdir -p "$AWESOME_DIR/test-package"
      echo '{"name": "test-package"}' > "$AWESOME_DIR/test-package/.awesome-manifest"
      When call read_manifest "test-package"
      The output should include "test-package"
      The status should be success
    End

    It 'checks if package is installed'
      mkdir -p "$AWESOME_DIR/test-package"
      touch "$AWESOME_DIR/test-package/test-package"
      chmod +x "$AWESOME_DIR/test-package/test-package"
      ln -s "$AWESOME_DIR/test-package/test-package" "$BIN_DIR/test-package"
      When call is_installed "test-package"
      The status should be success
    End
  End

  Describe 'Validation Functions'
    It 'validates working symlink'
      mkdir -p "$AWESOME_DIR/test-package"
      touch "$AWESOME_DIR/test-package/test-package"
      ln -s "$AWESOME_DIR/test-package/test-package" "$BIN_DIR/test-package"
      When call validate_symlink "test-package"
      The status should be success
    End

    It 'detects broken symlink'
      ln -s "$AWESOME_DIR/nonexistent/file" "$BIN_DIR/broken-link"
      When call validate_symlink "broken-link"
      The status should be failure
    End

    It 'finds broken symlinks'
      ln -s "$AWESOME_DIR/nonexistent/file" "$BIN_DIR/broken-link"
      When call find_broken_symlinks
      The output should include "broken-link"
      The status should be failure
    End

    It 'checks disk space'
      When call check_disk_space
      The status should be success
    End
  End

  Describe 'Utility Functions'
    It 'counts slashes in path'
      When call slashes "/path/to/file"
      The output should equal "3"
    End

    It 'extracts first part of path'
      When call first "/path/to/file"
      The output should equal "/path/to"
    End

    It 'extracts second part of path'
      When call second "/path/to/file"
      The output should equal "file"
    End

    It 'checks for no symlink'
      When call no_symlink "nonexistent" "$BIN_DIR"
      The status should be success
    End

    It 'detects existing symlink'
      touch "$BIN_DIR/exists"
      ln -s "$BIN_DIR/exists" "$BIN_DIR/link-exists"
      When call no_symlink "link-exists" "$BIN_DIR"
      The status should be failure
    End
  End

  Describe 'Package Operations'
    It 'gets package size'
      mkdir -p "$AWESOME_DIR/test-package"
      dd if=/dev/zero of="$AWESOME_DIR/test-package/file" bs=1024 count=100 2>/dev/null
      When call get_package_size "test-package"
      The output should not equal "N/A"
      The status should be success
    End

    It 'lists installed packages'
      mkdir -p "$AWESOME_DIR/pkg1" "$AWESOME_DIR/pkg2"
      touch "$AWESOME_DIR/pkg1/pkg1" "$AWESOME_DIR/pkg2/pkg2"
      ln -s "$AWESOME_DIR/pkg1/pkg1" "$BIN_DIR/pkg1"
      ln -s "$AWESOME_DIR/pkg2/pkg2" "$BIN_DIR/pkg2"
      When call list_installed_packages
      The output should include "pkg1"
      The output should include "pkg2"
    End
  End

  Describe 'Export Functions'
    It 'exports package list'
      mkdir -p "$AWESOME_DIR/test-pkg/.git"
      touch "$AWESOME_DIR/test-pkg/test-pkg"
      ln -s "$AWESOME_DIR/test-pkg/test-pkg" "$BIN_DIR/test-pkg"
      
      cd "$AWESOME_DIR/test-pkg" || exit
      git init -q
      git config user.email "test@test.com"
      git config user.name "Test"
      git remote add origin "https://github.com/test/test-pkg"
      cd - > /dev/null
      
      output_file="$TEST_DIR/packages.txt"
      When call export_packages "$output_file"
      The file "$output_file" should be exist
      The status should be success
    End
  End

  Describe 'Backward Compatibility'
    It 'maintains original checkOrmkdir function'
      test_dir="$TEST_DIR/new-dir"
      When call checkOrmkdir "$test_dir"
      The path "$test_dir" should be directory
      The status should be success
    End

    It 'maintains original checkDir function'
      mkdir -p "$TEST_DIR/exists"
      When call checkDir "$TEST_DIR/exists"
      The output should equal "1"
    End

    It 'maintains original checkFile function'
      touch "$TEST_DIR/testfile"
      When call checkFile "$TEST_DIR/testfile"
      The status should be success
    End

    It 'maintains original check_cmd function'
      When call check_cmd "bash"
      The status should be success
    End
  End
End
