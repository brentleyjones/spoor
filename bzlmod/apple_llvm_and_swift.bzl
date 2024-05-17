load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _apple_llvm_and_swift_impl(_):
    _SWIFT_VERSION = "5.9.2"

    http_archive(
        name = "llvm-raw",
        build_file_content = "# empty",
        # https://github.com/apple/llvm-project/pull/8766
        patches = ["//toolchain:llvm-raw.patch"],
        sha256 = "9df7cacc0107202dcdee8025d5cec9fe413f164e28921372acc61fddd78ed473",
        strip_prefix = "llvm-project-swift-{version}-RELEASE".format(version = _SWIFT_VERSION),
        url = "https://github.com/apple/llvm-project/archive/refs/tags/swift-{version}-RELEASE.tar.gz".format(version = _SWIFT_VERSION),
    )

    http_archive(
        name = "com_apple_swift",
        build_file = "@//toolchain:swift.BUILD",
        integrity = "sha256-W5PHN8JLp9hh4Hd4AHQOqpzN36KmpDJr1H28Wqmug3k=",
        patch_cmds = [
            "cat /dev/null > include/swift/Runtime/Config.h",
            """
            if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' 's/SWIFT_RUNTIME_EXPORT//g' include/swift/Demangling/Demangle.h
            else
            sed -i 's/SWIFT_RUNTIME_EXPORT//g' include/swift/Demangling/Demangle.h
            fi
            """,
        ],
        strip_prefix = "swift-swift-{version}-RELEASE".format(version = _SWIFT_VERSION),
        url = "https://github.com/apple/swift/archive/swift-{version}-RELEASE.tar.gz".format(version = _SWIFT_VERSION),
    )

apple_llvm_and_swift = module_extension(implementation = _apple_llvm_and_swift_impl)
