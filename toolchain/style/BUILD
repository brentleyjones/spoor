# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load("@buildifier_prebuilt//:rules.bzl", "buildifier")

buildifier(name = "buildifier")

sh_binary(
    name = "clang_format",
    srcs = ["clang_format.sh"],
    data = ["//:clang_format_config"],
    visibility = ["//visibility:public"],
)

sh_binary(
    name = "clang_tidy",
    srcs = ["clang_tidy.sh"],
    data = ["//:clang_tidy_config"],
    visibility = ["//visibility:public"],
)

sh_binary(
    name = "yapf",
    srcs = ["yapf.sh"],
    data = ["//:yapf_config"],
    visibility = ["//visibility:public"],
)

sh_binary(
    name = "pylint",
    srcs = ["pylint.sh"],
    data = ["//:pylint_config"],
    visibility = ["//visibility:public"],
)
