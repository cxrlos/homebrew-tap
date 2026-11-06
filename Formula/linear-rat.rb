class LinearRat < Formula
  desc "A fast, keyboard-first terminal client for Linear"
  homepage "https://github.com/cxrlos/linear-rat"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.1.0/linear-rat-aarch64-apple-darwin.tar.xz"
      sha256 "c1c0ff1a62091a74b15193e7979860e44b4dde233984ac5f01cd4eff01f65d6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.1.0/linear-rat-x86_64-apple-darwin.tar.xz"
      sha256 "55c459c93ff4438d4c382a5d17b4f3d08b6759d8c86ec3d95c94de8cc122ec51"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.1.0/linear-rat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "82c39bfd596e172667c8fcf5ffe71cf9416caf70a89226690d0140add4f92124"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.1.0/linear-rat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c310b8c301892de03fd86ebe78dbe1335ea5e3e81de53fe855a6bf1c7e9afff1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lrat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lrat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lrat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lrat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
