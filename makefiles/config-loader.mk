#!make

# Literal newline for reconstruction
define NL


endef

CONFIG_ENV_FILES := config.env $(wildcard config-local.env)
CONFIG_NL_MARKER := __CONFIG_NL__

# Read config files, prefix keys with CONFIG_, and eval them into Make.
# Notes:
# - Skips blank lines and full-line comments
# - Supports values with spaces (LINUX_PACKAGES_*)
# - Later files override earlier ones (config-local.env wins)
# - Escapes values containing `$` with `$$`.
$(eval $(subst $(CONFIG_NL_MARKER),$(NL),$(shell \
  awk ' \
    /^[[:space:]]*#/ { next } \
    /^[[:space:]]*$$/ { next } \
    { sub(/^[[:space:]]*export[[:space:]]+/, "", $$0) } \
    match($$0, /^([A-Za-z_][A-Za-z0-9_]*)=(.*)$$/, m) { \
      gsub(/\$$/, "$$$$", m[2]); \
      printf "CONFIG_%s := %s%s", m[1], m[2], "$(CONFIG_NL_MARKER)"; \
    } \
  ' $(CONFIG_ENV_FILES) \
)))
