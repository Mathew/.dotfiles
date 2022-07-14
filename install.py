import subprocess
from abc import ABC, abstractmethod 
from dataclasses import dataclass
from typing import Callable
from pathlib import Path, PosixPath


@dataclass
class CommandResult:
    ok: bool
    msg: str


class Application(ABC):
    @abstractmethod
    def check_install(self) -> CommandResult:
        ...

    @abstractmethod
    def install(self) -> CommandResult:
        ...


@dataclass
class SystemApplication(Application):
    name: str
    check_install_cmd: Callable
    run_cmd: list[str]
        
    def install(self) -> CommandResult:
        return install(run, self.run_cmd)()

    def check_install(self) -> CommandResult:
        return self.check_install_cmd()


def directory_exists(path: str) -> CommandResult:
    return CommandResult(PosixPath(path).expanduser().exists(), path)

def executable_on_path_exists(executable_name: str) -> CommandResult:
    return run(f"which {executable_name}")


@dataclass
class HomebrewApplication(Application):
    name: str
    cask: bool = False
    tapper: str = "homebrew/cask-fonts"
    install_name: str = ""

    def install(self) -> CommandResult:
        if self.tapper:
            result = run(f"brew tap {self.tapper}")
            if not result.ok:
                return result

        opts = "" if not self.cask else "--cask "
        return install(run, f"brew install {opts}{self.name}")()

    def check_install(self) -> CommandResult:
        return check_install(executable_on_path_exists, self.install_name if self.install_name else self.name)()


def run(cmd) -> CommandResult:
    completed = subprocess.run(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if completed.returncode != 0:
        return CommandResult(False, completed.stderr.decode('UTF-8').strip())

    return CommandResult(True, completed.stdout.decode('UTF-8').strip())


def check_install(func: Callable, *args) -> Callable:
    def closure() -> CommandResult:
        result = func(*args)
        if result.ok:
            return CommandResult(result.ok, "Existing install found: " + result.msg)
        return CommandResult(result.ok, "No installation found..")
    return closure


def install(func: Callable, cmd) -> Callable:
    def closure() -> CommandResult:
        result = func(cmd)
        if result.ok:
            return CommandResult(result.ok, "Installed.")
        return CommandResult(result.ok, f"Install failure: {result.msg}.")
    return closure


@dataclass
class Symlink:
    dir_to_symlink: str
    target_to_symlink: str

    def _expanded_target_path(self) -> str:
        return str(Path.cwd()) + f"/{self.target_to_symlink}"

    def _expanded_symlink_path(self) -> PosixPath:
        return PosixPath(self.dir_to_symlink).expanduser()

    def check(self):
        if self._expanded_symlink_path().exists():
            return CommandResult(True, f"Already created: {self.dir_to_symlink}")
        return CommandResult(False, f"Missing symlink from {self.dir_to_symlink} to {self._expanded_target_path()}")

    def create(self):
        self._expanded_symlink_path().symlink_to(self._expanded_target_path())
        return CommandResult(True, f"Created {self.dir_to_symlink}")


   

REQUIRED_APPS = (
    SystemApplication("brew", check_install(executable_on_path_exists, "brew"), ["/bin/bash", "-c NONINTERACTIVE=1", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"]),
    HomebrewApplication("tmux"),
    SystemApplication("packer", check_install(directory_exists, "~/.local/share/nvim/site/pack/packer/start/packer.nvim"), ["git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim"]),
    HomebrewApplication("fzf"),
    HomebrewApplication("tree"),
    HomebrewApplication("fd"),
    HomebrewApplication("python3"),
    HomebrewApplication("pyright"),
    HomebrewApplication("go"),
    HomebrewApplication("gopls"),
    HomebrewApplication("nvim"),
    HomebrewApplication("alacritty"),
    HomebrewApplication("ripgrep", install_name="rg"),
    HomebrewApplication("font-roboto-mono-nerd-font", cask=True),
)

SYMLINKS = (
    Symlink("~/.config/nvim", "nvim/.config"),
    Symlink("~/.tmux.conf", "tmux/tmux.conf"),
    Symlink("~/.config/bin", "bin"),
    Symlink("~/.config/alacritty", "alacritty"),
    Symlink("~/.config/fish", "fish"),
    Symlink("~/.config/starship.toml", "starship/starship.toml"),
)


def setup():
    for app in REQUIRED_APPS:
        print(f"==== {app.name} ====")
        print("Checking install...")
        result = app.check_install()
        print(result.msg)

        if result.ok is False:
            print("Installing...")
            result = app.install()
            print(result.msg)
        print(f"==== {app.name} ====\n\n")

    print("==== Symlinks ====")
    for symlink in SYMLINKS:
        result = symlink.check()
        if not result.ok:
            print(result.msg)
            print(symlink.create().msg)
        else:
            print(f"Symlink for {symlink.dir_to_symlink} already exists.")
        

    print("==== Symlinks ====\n\n")

if __name__ == "__main__":
    setup()

