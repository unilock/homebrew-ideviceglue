class LibirecoveryGit < Formula
  desc "Library and utility to talk to iBoot/iBSS via USB"
  homepage "https://www.libimobiledevice.org/"
  license "LGPL-2.1-only"
  head "https://git.libimobiledevice.org/libirecovery.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  # Only future versions require this lib, so do not treat it as a main dependency yet
  depends_on "libimobiledevice-glue-git"

  depends_on "libusb"
  depends_on "readline"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-debug-code"
    system "make", "install"
  end

  test do
    assert_match "ERROR: Unable to connect to device", shell_output("#{bin}/irecovery -f nothing 2>&1", 255)
  end
end
