# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load("@rules_python//python:pip.bzl", "compile_pip_requirements")

compile_pip_requirements(
    name = "requirements-dev",
    src = "requirements-dev.in",
)

filegroup(
    name = "clang_format_config",
    data = [".clang-format"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "clang_tidy_config",
    data = [".clang-tidy"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "yapf_config",
    data = [".style.yapf"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "pylint_config",
    data = ["@com_google_style_guide_pylintrc//file:pylintrc"],
    visibility = ["//visibility:public"],
)
