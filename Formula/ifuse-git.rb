class IfuseGit < Formula
  desc "FUSE module for iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license "LGPL-2.1-or-later"
  head "https://git.libimobiledevice.org/ifuse.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "glib"
  depends_on "libimobiledevice-git"
  depends_on "libplist-git"

  on_macos do
    disable! date: "2021-04-08", because: "requires closed-source macFUSE"
  end

  on_linux do
    depends_on "libfuse@2"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats
    on_macos do
      <<~EOS
        The reasons for disabling this formula can be found here:
          https://github.com/Homebrew/homebrew-core/pull/64491

        An external tap may provide a replacement formula. See:
          https://docs.brew.sh/Interesting-Taps-and-Forks
      EOS
    end
  end

  test do
    # Actual test of functionality requires osxfuse, so test for expected failure instead
    assert_match "ERROR: No device found!", shell_output("#{bin}/ifuse --list-apps", 1)
  end
end
