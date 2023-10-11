# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-11T18:42:37.35253352Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "3a5c0e3f92c32e275fc7919c56b4801bcb02b4b09ac7d1cd9bf76208263cd560"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/org.springframework.experimental.spring-cli-0.7.1-osx-x86_64.zip"
    sha256 "fa5f584a42899f4e00baaf8975882b3c10457b2e02c0bda1d970d74ee40c7581"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/org.springframework.experimental.spring-cli-0.7.1-osx-x86_64.zip"
    sha256 "fa5f584a42899f4e00baaf8975882b3c10457b2e02c0bda1d970d74ee40c7581"
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
