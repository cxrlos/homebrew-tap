class LinearRat < Formula
  desc "A fast, keyboard-first terminal client for Linear"
  homepage "https://github.com/cxrlos/linear-rat"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.2.0/linear-rat-aarch64-apple-darwin.tar.xz"
      sha256 "081c84a45b8f08b63e6e173d0be84aed38ea157ea18280c59bc1ffbc1f7739cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.2.0/linear-rat-x86_64-apple-darwin.tar.xz"
      sha256 "c8ff7474dbabf15684b0670b9c73a4b91ff7427d51e3af26495f79c9e2b2675a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.2.0/linear-rat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c22d0433a287af527625e7fcffaad09dd50fe6237c9a8591c6f4101be0a70b07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cxrlos/linear-rat/releases/download/v0.2.0/linear-rat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cbf2f5b34f4544b9a46748e090d343095494b59a775bb74f6e233fb6d690c772"
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
