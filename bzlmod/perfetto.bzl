load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _perfetto_impl(_):
    http_archive(
        # Perfetto's build config requires deviating from the naming convention.
        name = "perfetto",
        integrity = "sha256-3LgV+1Q3D6IKZXVSKIAWy2bnqYI3waHUfnZFpDJax14=",
        patch_cmds = [
            # On case-insensitve systems this file makes Bazel think there is a
            # package where there isn't one
            "rm ui/build",
        ],
        strip_prefix = "perfetto-45.0",
        url = "https://github.com/google/perfetto/archive/v45.0.tar.gz",
    )

    new_local_repository(
        # Perfetto's build config requires deviating from the naming convention.
        name = "perfetto_cfg",
        build_file_content = "",
        path = "toolchain/perfetto_overrides",
    )

perfetto = module_extension(implementation = _perfetto_impl)
