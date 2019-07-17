## Requirements

Bash, jq and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

## Usage example

```
env \
	AWS_DEFAULT_REGION=eu-west-2 \
	AWS_ACCESS_KEY_ID=1234 \
	AWS_SECRET_ACCESS_KEY=5678 \
		./send-metadata-create-message.sh \
			https://eu-west-2.queue.amazonaws.com/000011112222/main \
			1
```

This is just an example, tweak as needed!
