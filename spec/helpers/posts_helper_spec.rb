require "rails_helper"

RSpec.describe PostsHelper do

  describe "#post_length_in_minutes" do
    it "calculates the time to read an article" do
      five_hundred_words = "word " * 500
      actual = helper.post_length_in_minutes(five_hundred_words)
      expect(actual).to eq("2 min read")
    end

    it "can handle really short post" do
      less_than_one_hundred = "word " * 90
      actual = helper.post_length_in_minutes(less_than_one_hundred)
      expect(actual).to eq("less than a minute read")
    end
  end

  describe "#remove_javascript" do
    it "removes script tags" do
      html_with_script_tags = "<p onmouseover='$.ajax()'>Hello world</p><script>alert('XSS');</script>"
      output = helper.remove_javascript(html_with_script_tags)
      expect(output).to eq("<p '$.ajax()'>Hello world</p>alert('XSS');")
    end

    it "removes multiple script tag pairs" do
      html_with_script_tags = "<p>Hello world</p><script>alert('XSS');</script><h2>Hi</h2><script>alert('security')</script>"
      output = helper.remove_javascript(html_with_script_tags)
      expect(output).to eq("<p>Hello world</p>alert('XSS');<h2>Hi</h2>alert('security')")
    end

    it "removes javascript in href" do
      html_with_xss = "<a href='javascript:alert('XSS')'>Click me</a><br/><div onmouseover='alert('security hole!')'>some content</div>"
      output = helper.remove_javascript(html_with_xss)
      expect(output).to eq("<a href='alert('XSS')'>Click me</a><br/><div 'alert('security hole!')'>some content</div>")
    end
  end

  describe "#sanitize_html" do
    it "removes script tags" do
      html_with_script_tags = "<p>Hello world</p><script>alert('XSS');</script>"
      output = helper.sanitize_html(html_with_script_tags)
      expect(output).to eq("<p>Hello world</p>alert('XSS');")
    end

    it "removes multiple script tag pairs" do
      html_with_script_tags = "<p>Hello world</p><script>alert('XSS');</script><h2>Hi</h2><script>alert('security')</script>"
      output = helper.sanitize_html(html_with_script_tags)
      expect(output).to eq("<p>Hello world</p>alert('XSS');<h2>Hi</h2>alert('security')")
    end

    it "removes javascript in href" do
      html_with_xss = "<a href='javascript:alert('XSS')'>Click me</a><br/><div onmouseover='alert('security hole!')'>some content</div>"
      output = helper.sanitize_html(html_with_xss)
      expect(output).to eq("<a>Click me</a><br><div>some content</div>")
    end
  end
end
