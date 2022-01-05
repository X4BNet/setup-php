add_tools_helper() {
  tool=$1
  if [ "$tool" = "codeception" ]; then
    codeception_bin=$(grep codeception_bin "${GITHUB_ENV:?}" | cut -d '=' -f 2)
    sudo ln -s "${codeception_bin:?}"/codecept "${codeception_bin:?}"/codeception
  elif [ "$tool" = "composer" ]; then
    configure_composer "${tool_path:?}"
  elif [ "$tool" = "cs2pr" ]; then
    sudo sed -i 's/\r$//; s/exit(9)/exit(0)/' "${tool_path:?}" 2>/dev/null ||
    sudo sed -i '' 's/\r$//; s/exit(9)/exit(0)/' "${tool_path:?}"
  elif [ "$tool" = "phan" ]; then
    add_extension fileinfo extension 
    add_extension ast extension 
  elif [ "$tool" = "phive" ]; then
    add_extension curl extension 
    add_extension mbstring extension 
    add_extension xml extension 
  elif [ "$tool" = "phpDocumentor" ]; then
    add_extension fileinfo extension 
    sudo ln -s "${tool_path:?}" "${tool_path_dir:?}"/phpdocumentor 2>/dev/null || true
    sudo ln -s "${tool_path:?}" "${tool_path_dir:?}"/phpdoc
  elif [[ "$tool" =~ phpunit(-polyfills)?$ ]]; then
    if [ -e "${tool_path_dir:?}"/phpunit ]; then
      sudo cp "${tool_path_dir:?}"/phpunit "${composer_bin:?}"
    fi
  elif [[ "$tool" =~ (symfony|vapor|wp)-cli ]]; then
    sudo ln -s "${tool_path:?}" "${tool_path_dir:?}"/"${tool%-*}"
  fi
}