#!/bin/bash
curr_dir=$(pwd)
echo "#!/bin/bash" > clone.sh
chmod +x clone.sh
for d in */ ; do
  file_name=$curr_dir/$d".git/config "
  repo_url=$(cat $file_name | grep ssh:// | cut -d'=' -f 2 | cut -d' ' -f2)
  echo "[ ! -d "$d" ] && git clone "$repo_url >> clone.sh
done