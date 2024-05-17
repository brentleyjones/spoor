load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@llvm-raw//utils/bazel:configure.bzl", "llvm_configure")
load("@llvm-raw//utils/bazel:terminfo.bzl", "llvm_terminfo_from_env")
load("@llvm-raw//utils/bazel:zlib.bzl", "llvm_zlib_from_env")

def _llvm_deps_impl(_):
    llvm_configure(name = "llvm-project")

    llvm_terminfo_from_env(
        name = "llvm_terminfo",
    )

    http_archive(
        name = "zlib",
        build_file = "@llvm-raw//utils/bazel/third_party_build:zlib.BUILD",
        sha256 = "91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9",
        strip_prefix = "zlib-1.2.12",
        urls = [
            "https://storage.googleapis.com/mirror.tensorflow.org/zlib.net/zlib-1.2.12.tar.gz",
            "https://zlib.net/zlib-1.2.12.tar.gz",
        ],
    )

    llvm_zlib_from_env(
        name = "llvm_zlib",
        external_zlib = "@zlib",
    )

llvm_deps = module_extension(implementation = _llvm_deps_impl)
