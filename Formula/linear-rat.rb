class LinearRat < Formula
  desc "A fast, keyboard-first terminal client for Linear"
  homepage "https://github.com/cxrlos/linear-rat"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.3.0/linear-rat-aarch64-apple-darwin.tar.xz"
      sha256 "b78c66afb0ef6a0d755a5a874c29bc9ad1bb91fee3184cfbf69fc4d3bfe3e227"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.3.0/linear-rat-x86_64-apple-darwin.tar.xz"
      sha256 "8f9544e2cbd77bbc96ad8d7cd02e953572de71ab0783c2335779569324c16f80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.3.0/linear-rat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9c1a785ac3ede49cefa5a4ca26002cbeb384be2343be2ea3f79a8fe1f44e8a77"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.3.0/linear-rat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1676b8c3f89a036cf333b66f4cc32b1ee07fc2c38bfc1c4af7b97e9f8fe1917"
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
