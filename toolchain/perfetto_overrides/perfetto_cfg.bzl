# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Documentation:
# https://github.com/google/perfetto/tree/master/bazel/standalone

PERFETTO_CONFIG = struct(
    root = "//",
    deps = struct(
        build_config = ["//:build_config_hdr"],
        version_header = ["//:cc_perfetto_version_header"],
        base_platform = ["//:perfetto_base_default_platform"],
        zlib = ["@perfetto_dep_zlib//:zlib"],
        jsoncpp = ["@perfetto_dep_jsoncpp//:jsoncpp"],
        linenoise = ["@perfetto_dep_linenoise//:linenoise"],
        sqlite = ["@perfetto_dep_sqlite//:sqlite"],
        sqlite_ext_percentile = ["@perfetto_dep_sqlite_src//:percentile_ext"],
        protoc = ["@protobuf//:protoc"],
        protoc_lib = ["@protobuf//:protoc_lib"],
        protobuf_lite = ["@protobuf//:protobuf_lite"],
        protobuf_full = ["@protobuf//:protobuf"],
        protobuf_descriptor_proto = ["@protobuf//:descriptor_proto"],
        demangle_wrapper = ["//:src_trace_processor_demangle"],
        # TODO: Reuse our llvm to prevent compiling this twice?
        llvm_demangle = ["@perfetto_dep_llvm_demangle//:llvm_demangle"],
    ),
    public_visibility = ["//visibility:public"],
    proto_library_visibility = "//visibility:public",
    go_proto_library_visibility = "//visibility:private",
    default_copts = [
        "-std=c++17",
    ],
)
