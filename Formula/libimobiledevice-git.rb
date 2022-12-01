class LibimobiledeviceGit < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://www.libimobiledevice.org/"
  license "LGPL-2.1-or-later"
  head "https://git.libimobiledevice.org/libimobiledevice.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libtasn1"
  depends_on "openssl@1.1"

  depends_on "libimobiledevice-glue-git"

  depends_on "libplist-git"
  depends_on "libusbmuxd-git"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          # As long as libplist builds without Cython
                          # bindings, libimobiledevice must as well.
                          "--without-cython",
                          "--enable-debug-code"
    system "make", "install"
  end

  test do
    system "#{bin}/idevicedate", "--help"
  end
end
