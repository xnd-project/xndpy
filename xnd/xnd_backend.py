from flit.buildapi import build_wheel as _build_wheel
from flit.buildapi import build_sdist as _build_sdist
import os, platform, shutil
import subprocess, sys, sysconfig

def check_err(proc):
    if proc.returncode != 0:
        raise RuntimeError("executing cmake commands failed")

def call_cmake(install_prefix):
    proc = subprocess.run(["cmake",
                           "-S", "../source/xnd",
                           "-DCMAKE_BUILD_TYPE=Release",
                           "-DCMAKE_INSTALL_PREFIX=%s" % install_prefix,
                           "-DPython3_EXECUTABLE=%s" % sys.executable,
                           "-DMOD_XND_WITH_XNDLIB=ON"])
    check_err(proc)

    proc = subprocess.run(["cmake",
                           "--build", ".",
                           "--config", "Release",
                           "--target", "install",
                           "--parallel"])
    check_err(proc)

def build_wheel(wheel_dir, config_settings=None, metadata_directory=None):

    arch = "x64" if platform.architecture()[0] == "64bit" else "x86"
    mingw = "mingw" in sysconfig.get_platform()
    install_prefix = os.path.abspath(os.path.dirname(__file__))

    if sys.platform == "win32" and not mingw:
        proc = subprocess.run(["build.bat", sys.executable, arch, install_prefix])
    else:
        if os.path.isdir("ndtypes_build"):
            shutil.rmtree("ndtypes_build")
        os.mkdir("xnd_build")
        os.chdir("xnd_build")

        try:
            call_cmake(install_prefix)
        finally:
            os.chdir("..")

    return _build_wheel(wheel_dir, config_settings, metadata_directory)

def build_sdist(sdist_dir, config_settings=None):
    return _build_sdist(sdist_dir, config_settings)
