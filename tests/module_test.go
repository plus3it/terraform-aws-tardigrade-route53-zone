package testing

import (
	"io/ioutil"
	"log"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModule(t *testing.T) {
	files, err := ioutil.ReadDir("./")

	if err != nil {
		log.Fatal(err)
	}

	for _, f := range files {
		uniqueID := strings.ToLower(random.UniqueId())
		envVars := map[string]string{
			"TF_VAR_test_id": uniqueID,
		}

		// look for directories with test cases in it
		if f.IsDir() && f.Name() != "vendor" {
			tfFiles, tfErr := ioutil.ReadDir(f.Name())

			if tfErr != nil {
				log.Fatal(tfErr)
			}

			// check if directory contains terraform files
			terraformDir := false
			for _, tf := range tfFiles {
				if strings.HasSuffix(tf.Name(), ".tf") {
					terraformDir = true
					break
				}
			}

			// create a test for each directory with terraform files in it
			if terraformDir {
				t.Run(f.Name(), func(t *testing.T) {
					// check if a prereq directory exists
					prereqDir := f.Name() + "/prereq/"
					if _, err := os.Stat(prereqDir); err == nil {
						prereqOptions := createTerraformOptions(prereqDir, envVars)
						defer terraform.Destroy(t, prereqOptions)
						terraform.InitAndApply(t, prereqOptions)
					}

					// run terraform code for test case
					terraformOptions := createTerraformOptions(f.Name(), envVars)
					defer terraform.Destroy(t, terraformOptions)
					terraform.InitAndApply(t, terraformOptions)
				})
			}
		}
	}
}

func createTerraformOptions(directory string, envVars map[string]string) *terraform.Options {
	terraformOptions := &terraform.Options{
		TerraformDir: directory,
		NoColor:      true,
		EnvVars:      envVars,
	}

	return terraformOptions
}
