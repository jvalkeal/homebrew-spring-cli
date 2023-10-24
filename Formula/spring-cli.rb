# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-24T08:46:52.529986312Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "12fb07f69531bac132c423838bde63f81f6a47be5a0f753ccb731096a45ad82a"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "6909b7cfd2b02c5d814678d4ce305ff30ecda8d5922da1c9e611446e84b1b1ca"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "6909b7cfd2b02c5d814678d4ce305ff30ecda8d5922da1c9e611446e84b1b1ca"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
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
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.1", output
  end
end
