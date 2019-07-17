#!/usr/bin/env bash

set -o errexit
set -o pipefail

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sample="${__dir}/testdata/message-metadata-create.json"
uuid=$(uuidgen)
tmpfile=$(mktemp /tmp/test-send-message.XXXXXX)
title="test-$(date +"%Y%m%d%H%M%S")"

if [ -z "$1" ]; then
		echo "Missing parameter: queueURL (pos 1)"
		exit 1
fi
queueURL=${1}

if [ -z "$2" ]; then
		echo "Missing parameter: tenantJiscID (pos 2)"
		exit 1
fi
tenantJiscID=${2}

cat ${sample} | jq '.messageBody.objectTitle = "'${title}'" | .messageHeader.tenantJiscID = '${tenantJiscID}' | .messageHeader.messageId = "'${uuid}'"' > ${tmpfile}
echo "Message generated: ${tmpfile}"

if [ -z "${AWS_DEFAULT_REGION}" ]; then
		export AWS_DEFAULT_REGION="eu-west-2"
fi

aws sqs send-message \
	--delay-seconds 2 \
	--queue-url ${queueURL} \
	--message-body file://${tmpfile}
