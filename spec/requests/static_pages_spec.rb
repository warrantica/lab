require 'spec_helper'

describe "StaticPages" do
	describe "Home page" do
		it "should have the content 'Sample App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', 
				:text => "Home")
		end

		it "should have the right title" do
			visit '/static_pages/home'
			page.should have_selector('title',
				:text => "Sample App | Home")
		end
	end

	describe "About Page" do
		it "should have the content 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', 
				:text => "About")
		end

		it "should have the right title" do
			visit '/static_pages/about'
			page.should have_selector('title',
				:text => "Sample App | About")
		end
	end

	describe "Help Page" do
		it "should have the content 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', 
				:text => "Help")
		end

		it "should have the right title" do
			visit '/static_pages/help'
			page.should have_selector('title',
				:text => "Sample App | Help")
		end
	end
end