# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-16T09:37:43.740646964Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.5"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-linux.x86_64.zip"
    sha256 "029d9e9a586706ef0cfc36ee57bd37b0f638db3fd0a3ddc12ec23c951775a5ad"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.aarch64.zip"
    sha256 "73c238cb0314cb44e97325e1706cb119d57caa986266d537023d8731f351c8ad"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.x86_64.zip"
    sha256 "94c1d64b1ff9a1f28abd38e7351a1e75229642dd7a0f1b69d74a87a58b0dfc1f"
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
    assert_match "0.7.5", output
  end
end
