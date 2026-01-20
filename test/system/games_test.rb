require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # 1️⃣ Random grid displays 10 letters
  test "visiting /new shows a new random grid" do
    visit new_path
    assert_selector "ul.letter-grid li", count: 10
  end

  # 2️⃣ Word not in the grid
  test "submitting a word not in the grid shows error" do
    visit new_path
    fill_in "word", with: "ZZZZ"   # unlikely to appear in random letters
    click_on "Play!"
    assert_text "can't be built out of the grid"
  end

  # 3️⃣ Word in grid but invalid English word
  test "submitting a grid word that is not a valid English word shows error" do
    visit new_path
    letters = find("ul.letter-grid").text.split(" ")
    fill_in "word", with: letters.first  # just one letter
    click_on "Play!"
    assert_text "not a valid English word"
  end

  # 4️⃣ Valid English word in grid
  test "submitting a valid English word in the grid shows success" do
    visit new_path

    # Fix the letters for testing
    page.execute_script('document.querySelector("input[name=letters]").value = "T E S T X Y Z Q W U"')

    fill_in "word", with: "TEST"
    click_on "Play!"
    assert_text "Congratulations"
  end
end
