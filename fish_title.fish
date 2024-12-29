function fish_title
  set -l full_path (pwd)

  set -l current_dir (basename $full_path)
  set -l parrent_dir (basename (dirname $full_path))

  echo $parrent_dir/$current_dir
end