ssm() {
  local instance_ids selection
  local -a region

  [[ -n "${1}" ]] && region=(--region "${1}")

  instance_ids="$(
    aws "${region[@]}" ssm describe-instance-information \
      --filters \
        "Key=PingStatus,Values=Online" \
        "Key=ResourceType,Values=EC2Instance" \
      --query "InstanceInformationList[].InstanceId" \
      --output json
  )" || return

  selection="$(
    aws "${region[@]}" ec2 describe-instances --output json |
      jq -r --argjson instance_ids "${instance_ids}" '
        [
          .Reservations[].Instances[]
          | select(.InstanceId as $id | $instance_ids | index($id))
          | {
              name: ([.Tags[]? | select(.Key == "Name") | .Value][0] // "(unnamed)"),
              id: .InstanceId
            }
        ]
        | sort_by(.name)
        | (map(.name | length) | max // 4) as $widest_name
        | ($widest_name | if . < 4 then 4 else . end) as $name_width
        | ("NAME" + (" " * ($name_width - 4 + 2)) + "INSTANCE ID") as $header
        | ([$header, ""] | @tsv),
          (.[] | [
            (.name + (" " * ($name_width - (.name | length) + 2)) + .id),
            .id
          ] | @tsv)
      ' |
      fzf \
        --layout=reverse \
        --height='~50%' \
        --border=rounded \
        --header-lines=1 \
        --delimiter=$'\t' \
        --with-nth=1 \
        --prompt="SSM instance> "
  )" || return

  aws "${region[@]}" ssm start-session --target "${selection##*$'\t'}"
}
