$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

# add new docs here
$validDocs = @(
	@{
		category = @("databases"); groupDescription = "Databases";
		names = @(
			@{ name = @("mongodb", "mongo"); url = "docs.mongodb.com/" }
			@{ name = @("mongoose"); url = "mongoosejs.com/docs/index.html" }
			@{ name = @("mlab"); url = "docs.mlab.com/" }
			@{ name = @("lokijs", "loki"); url = "github.com/techfort/LokiJS#lokijs" }
			@{ name = @("postgres"); url = "www.postgresql.org/docs/current/" }
		)
	}
	@{
		category = @("backEnd"); groupDescription = "Back End";
		names = @(
			@{ name = @("node"); url = "nodejs.org/en/docs/" }
			@{ name = @("nodemon"); url = "github.com/remy/nodemon#nodemon" }
			@{ name = @("postman"); url = "learning.postman.com/docs/getting-started/introduction/" }
			@{ name = @("insomnia"); url = "insomnia.rest/" }
			@{ name = @("joi"); url = "joi.dev/api" }
			@{ name = @("twilio"); url = "www.twilio.com/docs" }
			@{ name = @("axios"); url = "axios-http.com/docs/intro" }
			@{ name = @("passportjs", "passport"); url = "www.passportjs.org/docs/" }
			@{ name = @("jwt", "jsonwebtokens", "webtokens"); url = "www.npmjs.com/package/jsonwebtoken" }
			@{ name = @("json-server"); url = "github.com/typicode/json-server" }
			@{ name = @("graphql", "graph"); url = "graphql.org/learn/" }
		)
	}
	@{
		category = @("dev"); groupDescription = "Dev";
		names = @(
			@{ name = @("npm"); url = "www.npmjs.com/" }
			@{ name = @("yarn"); url = "yarnpkg.com/getting-started" }
			@{ name = @("babel"); url = "babeljs.io/docs/en/" }
			@{ name = @("eslint", "lint"); url = "eslint.org/docs/user-guide/" }
			@{ name = @("prettier"); url = "prettier.io/docs/en/index.html" }
			@{ name = @("browserslist", "browsers"); url = "browserslist.dev/" }
			@{ name = @("create-react-app", "react-app", "cra"); url = "create-react-app.dev/docs/getting-started/" }
			@{ name = @("prop-types", "proptypes"); url = "https://www.npmjs.com/package/prop-types" }
			@{ name = @("curl"); url = "curl.se/docs/tooldocs.html" }
		)
	}
	@{
		category = @("git"); groupDescription = "Git";
		names = @(
			@{ name = @("git"); url = "git-scm.com/docs" }
			@{ name = @("github", "gh"); url = "docs.github.com/en" }
			@{ name = @("posh-git", "posh"); url = "github.com/dahlbyk/posh-git" }
		)
	}
	@{
		category = @("bundlers"); groupDescription = "Bundlers";
		names = @(
			@{ name = @("parcel"); url = "parceljs.org/docs/" }
			@{ name = @("webpack", "wp"); url = "webpack.js.org/concepts/" }
			@{ name = @("browserify"); url = "browserify.org/" }
			@{ name = @("esbuild"); url = "esbuild.github.io/" }
			@{ name = @("snowpack", "snow"); url = "www.snowpack.dev/" }
			@{ name = @("vite"); url = "vitejs.dev/guide/#overview" }
			@{ name = @("rollup"); url = "www.rollupjs.org/guide/en/" }
		)
	}
	@{
		category = @("libraries"); groupDescription = "Libraries";
		names = @(
			@{ name = @("react"); url = "reactjs.org/docs/getting-started.html" }
			@{ name = @("react-router", "reactrouter"); url = "https://reactrouter.com/docs" }
			@{ name = @("redux"); url = "redux.js.org/api" }
			@{ name = @("redux-toolkit", "reduxtoolkit", "redux-tk"); url = "redux-toolkit.js.org/api/configureStore" }
			@{ name = @("recoil"); url = "recoiljs.org/" }
			@{ name = @("formik"); url = "formik.org/docs/overview" }
			@{ name = @("immutable"); url = "immutable-js.com/" }
			@{ name = @("immer"); url = "immerjs.github.io/immer" }
			@{ name = @("jquery"); url = "learn.jquery.com/" }
			@{ name = @("lodash"); url = "lodash.com/docs/4.17.15" }
			@{ name = @("rxjs", "rx"); url = "rxjs.dev/guide/overview" }
			@{ name = @("moment"); url = "momentjs.com/docs/" }
			@{ name = @("date-fns", "datefns"); url = "date-fns.org/docs/Getting-Started" }
		)
	}
	@{
		category = @("frameworks"); groupDescription = "Frameworks";
		names = @(
			@{ name = @("express"); url = "expressjs.com/" }
			@{ name = @("angular"); url = "angular.io/docs" }
			@{ name = @("vue"); url = "vuejs.org/guide" }
			@{ name = @("nextjs", "next"); url = "nextjs.org/docs/getting-started" }
			@{ name = @("electron"); url = "www.electronjs.org/docs/latest" }
			@{ name = @("evergreen"); url = "evergreen.segment.com/introduction/getting-started" }
			@{ name = @("gatsby"); url = "www.gatsbyjs.com/" }
		)
	}
	@{
		category = @("css"); groupDescription = "CSS";
		names = @(
			@{ name = @("react-bootstrap", "react-bs", "rbs"); url = "react-bootstrap.github.io/" }
			@{ name = @("bootstrap", "bs"); url = "getbootstrap.com/docs/5.1/getting-started/introduction/" }
			@{ name = @("tailwindcss", "tailwind", "twcss", "tw"); url = "tailwindcss.com/docs" }
			@{ name = @("sass"); url = "sass-lang.com/guide" }
			@{ name = @("popmotion", "pop"); url = "popmotion.io/" }
		)
	}
	@{
		category = @("testing"); groupDescription = "Testing";
		names = @(
			@{ name = @("jest"); url = "jestjs.io/docs/getting-started" }
			@{ name = @("mocha"); url = "mochajs.org/#installation" }
			@{ name = @("jasmine"); url = "jasmine.github.io/pages/docs_home.html" }
		)
	}
	@{
		category = @("miscellaneous", "other"); groupDescription = "Miscellaneous";
		names = @(
			@{ name = @("ecma"); url = "262.ecma-international.org/12.0/" }
			@{ name = @("typescript", "ts"); url = "www.typescriptlang.org/docs/" }
			@{ name = @("flow"); url = "flow.org/en/docs/" }
			@{ name = @("runjs", "run"); url = "runjs.app/docs" }
			@{ name = @("chart"); url = "docs.anychart.com/Quick_Start/Quick_Start" }
			@{ name = @("explainshell", "shell"); url = "explainshell.com/" }
			@{ name = @("powershell-gallery", "pwsh-gallery", "gallery"); url = "www.powershellgallery.com/" }
		)
	}
)

if (Ask-Help $params $helpParams) {
	$params = Get-Params $params -help -helpParams $helpParams
	Show-ValidSet $validDocs -values $values -params $params
}
else {
	# create boolean variables
	$localParams = Get-Params $params -validParams $validDocs -local
	$booleanNames = Get-BooleanNames $localParams $validDocs $helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	$url = ""
	$docs = $values
	
	if (!$docs) {
		write-host "provide docs " -ForegroundColor Red -NoNewline
		write-host "(--help to list)" -ForegroundColor DarkGray -NoNewline
	}
	else {
		if ($docs) {
			# validate doc names
			foreach ($doc in $docs) {
				if (!($doc -in $validDocs.names.name -or $doc -in $validDocs.names.short)) {
					$docs = $docs | Where-Object { $_ -ne $doc }
				}
			}

			# get the docs that are available
			$getDocs = @()
			foreach ($doc in $docs) {
				foreach ($validDoc in $validDocs.names) {
					if ($doc -in $validDoc.name -or $doc -in $validDoc.short) {
						$getDocs += $validDoc
					}
				}
			}

			# open url
			if ($getDocs) {
				foreach ($doc in $getDocs) {
					$url = $doc.url
					& q $url $params
				}
			}
			else {
				Print-Error "no matches"
			}
		}
	}
}
