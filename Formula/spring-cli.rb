# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-19T08:28:17.167490489Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.7"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.7/spring-cli-standalone-0.7.7-linux.x86_64.zip"
    sha256 "b33379e0b3b0f791d838c5cdf4287a4a02a9c6c161f1aaca742dc3b2b498b818"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.7/spring-cli-standalone-0.7.7-osx.aarch64.zip"
    sha256 "e1a349f06c4cfb3260a39b01ebfc2da4364f8c27f1862d36f38928b8b8fc771f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.7/spring-cli-standalone-0.7.7-osx.x86_64.zip"
    sha256 "386aac417eb0427bfceee7f7d3d7331deb5016827500fe7ff4f70eeb5b9e2823"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.7", output
  end
end
