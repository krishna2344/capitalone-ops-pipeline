#!/usr/bin/env bats

@test "sonarqube is installed" {
  run which sonarqube
  [ "$status" -eq 0 ]
}

@test "sonarqube is working" {
  dir=$( mktemp -d )
  cd $dir
  wget -q https://github.com/SonarSource/sonar-examples/archive/master.zip
  unzip -q master.zip
  wget -q http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
  unzip -q sonar-runner-dist-2.4.zip

  sudo sonarqube start && sleep 30

  cd sonar-examples-master/projects/languages/java/sonar-runner/java-sonar-runner-simple/
  run ../../../../../../sonar-runner-2.4/bin/sonar-runner
  [ "$status" -eq 0 ]
}

