#!/bin/bash

set -x
set -e

REPO=https://repo1.maven.org/maven2

get_dep () {
    echo getting $1...
    wget --timestamping --quiet $1 -P $2
}
get_spark_dep () {
    get_dep $1 $SPARK_HOME/jars
}
get_spark_dep_group () {
    deps="$1"
    dep_group=$2
    dep_group_ver=$3
    for dep in $deps; do
	get_spark_dep $REPO/${dep_group}/$dep/$dep_group_ver/$dep-$dep_group_ver.jar
    done
}
get_spark_deps () {
    deps="aws-java-sdk"
    dep_group="com/amazonaws"
    dep_group_ver=1.7.4
    get_spark_dep_group "$deps" $dep_group $dep_group_ver
    
    deps="hadoop-aws"
    dep_group="org/apache/hadoop"
    dep_group_ver=2.7.3
    get_spark_dep_group "$deps" $dep_group $dep_group_ver
}

$*




    
