# Generated with JReleaser 1.8.0 at 2023-09-28T08:58:37.062145827+01:00
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-0.7.1.zip"
  version "0.7.1"
  sha256 "a63bfb384f56a76403bcba89f20bee95c18e06f8ac26a867901ce51025176ecd"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.1", output
  end
end
