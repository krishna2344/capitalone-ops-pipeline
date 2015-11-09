#!/usr/bin/env bats

@test "java binary is found in PATH" {
  run which java
  [ "$status" -eq 0 ]
}

@test "JAVA_HOME is set" {
  run test -d $JAVA_HOME
  [ "$status" -eq 0 ]
}
