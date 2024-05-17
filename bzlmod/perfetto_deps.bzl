load("@perfetto//bazel:deps.bzl", _perfetto_deps = "perfetto_deps")

def _perfetto_deps_impl(_):
    _perfetto_deps()

perfetto_deps = module_extension(implementation = _perfetto_deps_impl)
