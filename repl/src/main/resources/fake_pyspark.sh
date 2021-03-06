#!/usr/bin/env bash
# Licensed to Cloudera, Inc. under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  Cloudera, Inc. licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

if [ -z "$SPARK_HOME" ]; then
	echo "\$SPARK_HOME is not set" 1>&2
	exit 1
fi

export SPARK_CONF_DIR="$SPARK_HOME/conf"

source "$SPARK_HOME/bin/utils.sh"
source "$SPARK_HOME/bin/load-spark-env.sh"

export PYTHONPATH="$SPARK_HOME/python/:$PYTHONPATH"

for path in $(ls $SPARK_HOME/python/lib/*.zip); do
	export PYTHONPATH="$path:$PYTHONPATH"
done

export OLD_PYTHONSTARTUP="$PYTHONSTARTUP"
export PYTHONSTARTUP="$SPARK_HOME/python/pyspark/shell.py"

exec python "$@"
