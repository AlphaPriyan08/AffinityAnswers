from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import csv
import time

def scrape_olx_car_cover(filename='olx_car_cover_results.csv'):
    options = Options()
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')

    driver = webdriver.Chrome(options=options)  # Make sure chromedriver is installed and in PATH
    driver.get('https://www.olx.in/items/q-car-cover')

    time.sleep(5)  # Wait for page to load fully

    items = driver.find_elements(By.CSS_SELECTOR, "li[data-aut-id='itemBox']")

    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['Title', 'Price', 'Location', 'Link'])

        for item in items:
            try:
                title = item.find_element(By.CSS_SELECTOR, "span[data-aut-id='itemTitle']").text
            except:
                title = "N/A"
            try:
                price = item.find_element(By.CSS_SELECTOR, "span[data-aut-id='itemPrice']").text
            except:
                price = "N/A"
            try:
                location = item.find_element(By.CSS_SELECTOR, "span[data-aut-id='item-location']").text
            except:
                location = "N/A"
            try:
                link = item.find_element(By.TAG_NAME, "a").get_attribute('href')
            except:
                link = "N/A"

            writer.writerow([title, price, location, link])

    print(f"Scraped data saved to {filename}")
    driver.quit()

if __name__ == "__main__":
    scrape_olx_car_cover()
