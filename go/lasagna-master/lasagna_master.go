package lasagna

func PreparationTime(layers []string, prepTime int) int {
	if prepTime == 0 {
		prepTime = 2
	}

	return len(layers) * prepTime
}

func Quantities(layers []string) (int, float64) {
	gramsNoodle := 0
	litersSauce := 0.0

	for _, ingredient := range layers {
		if ingredient == "noodles" {
			gramsNoodle += 50
		}

		if ingredient == "sauce" {
			litersSauce += 0.2
		}
	}

	return gramsNoodle, litersSauce
}

func AddSecretIngredient(specialRecipe, myRecipe []string) {
	myRecipe[len(myRecipe)-1] = specialRecipe[len(specialRecipe)-1]
}

func ScaleRecipe(quantities []float64, numPortions int) []float64 {
	scaledQuantities := make([]float64, len(quantities))
	for i, amount := range quantities {
		scaledQuantities[i] = amount * float64(numPortions) / 2.0
	}

	return scaledQuantities
}
