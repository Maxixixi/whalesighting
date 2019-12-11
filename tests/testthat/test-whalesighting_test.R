library(whalesighting)

test_that("checkWhale returns the number of whale sightings", {
  expect_equal(checkWhale("orca"), "There are 18775 records of orca in the recent 1000 sightings (1000 is the maximum)")
  expect_equal(checkWhale("humpback"),"There are 3 records of humpback in the recent 1000 sightings (1000 is the maximum)")
})

test_that("checkWhale tells users there are no sightings for a undocumented whale type", {
  expect_equal(checkWhale("blue whale"), "There are no records of blue whale in the recent 1000 sightings (1000 is the maximum)")
  expect_equal(checkWhale("Sei Whale"), "There are no records of sei whale in the recent 1000 sightings (1000 is the maximum)")
})
