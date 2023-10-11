# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-11T10:49:42.652253913Z
class SpringCliJlink < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-jlink-0.7.1-linux.x86_64.zip"
    sha256 "7025ba346e88bc87c9d646c63ee6138fc65510834792c83a68adf08c5a1e1266"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring-cli-jlink" => "spring-cli-jlink"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring-cli-jlink --version")
    assert_match "0.7.1", output
  end
end
