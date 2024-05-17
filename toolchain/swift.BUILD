# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "llvm_overlay",
    hdrs = glob([
        "stdlib/include/llvm/ADT/**/*.h",
        "stdlib/include/llvm/Support/**/*.h",
    ]),
    includes = ["stdlib/include"],
    tags = ["manual"],
)

cc_library(
    name = "swift",
    hdrs = glob([
        "include/swift/*.h",
        "include/swift/AST/*.h",
        "include/swift/Basic/*.h",
    ]),
    includes = ["include"],
    tags = ["manual"],
    textual_hdrs = glob([
        "include/swift/AST/*.def",
    ]),
)

cc_library(
    name = "SwiftShims",
    hdrs = glob([
        "stdlib/public/SwiftShims/**/*.h",
    ]),
    includes = ["stdlib/public/SwiftShims"],
    tags = ["manual"],
)

cc_library(
    name = "Demangling",
    srcs = glob([
        "lib/Demangling/*.cpp",
        "lib/Demangling/*.h",
        "include/swift/Demangling/*.h",
    ]),
    hdrs = [
        "include/swift/Demangling/Demangle.h",
    ],
    copts = [
        "-std=c++17",
        "-Wno-dollar-in-identifier-extension",
        "-Wno-unused-parameter",
    ],
    includes = ["include"],
    local_defines = ["SWIFT_STDLIB_HAS_TYPE_PRINTING"],
    tags = ["manual"],
    textual_hdrs = glob([
        "include/swift/Demangling/*.def",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        # Use LLVM over Swift versions, so this has to be first, otherwise we
        # get linking errors such as:
        #
        # ld: Undefined symbols:
        #   swift::Demangle::isSwiftSymbol(llvm::StringRef), referenced from:
        #       spoor::instrumentation::inject_instrumentation::InjectInstrumentation::InstrumentModule(gsl::not_null<llvm::Module*>, spoor::instrumentation::filters::Filters const&) const::$_0::operator()() const in libinject_instrumentation.a[2](inject_instrumentation.o)
        "@llvm-project//llvm:Support",
        ":SwiftShims",
        ":swift",
        ":llvm_overlay",
    ],
)
