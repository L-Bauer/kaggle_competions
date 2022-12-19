{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "525d77c7",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:44.251703Z",
     "iopub.status.busy": "2022-12-19T16:46:44.249524Z",
     "iopub.status.idle": "2022-12-19T16:46:45.549014Z",
     "shell.execute_reply": "2022-12-19T16:46:45.547108Z"
    },
    "papermill": {
     "duration": 1.309577,
     "end_time": "2022-12-19T16:46:45.551809",
     "exception": false,
     "start_time": "2022-12-19T16:46:44.242232",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dplyr’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n",
      "Loading required package: ggplot2\n",
      "\n",
      "Loading required package: ggstance\n",
      "\n",
      "\n",
      "Attaching package: ‘ggstance’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:ggplot2’:\n",
      "\n",
      "    geom_errorbarh, GeomErrorbarh\n",
      "\n",
      "\n",
      "Loading required package: scales\n",
      "\n",
      "\n",
      "Attaching package: ‘scales’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:readr’:\n",
      "\n",
      "    col_factor\n",
      "\n",
      "\n",
      "Loading required package: ggridges\n",
      "\n",
      "\n",
      "New to ggformula?  Try the tutorials: \n",
      "\tlearnr::run_tutorial(\"introduction\", package = \"ggformula\")\n",
      "\tlearnr::run_tutorial(\"refining\", package = \"ggformula\")\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'spaceship-titanic'"
      ],
      "text/latex": [
       "'spaceship-titanic'"
      ],
      "text/markdown": [
       "'spaceship-titanic'"
      ],
      "text/plain": [
       "[1] \"spaceship-titanic\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(readr)\n",
    "library(dplyr)\n",
    "library(ggformula)\n",
    "library(tidyr)\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "580e1584",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:45.602304Z",
     "iopub.status.busy": "2022-12-19T16:46:45.562732Z",
     "iopub.status.idle": "2022-12-19T16:46:45.682640Z",
     "shell.execute_reply": "2022-12-19T16:46:45.679917Z"
    },
    "papermill": {
     "duration": 0.129855,
     "end_time": "2022-12-19T16:46:45.685990",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.556135",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>HomePlanet</th><th scope=col>CryoSleep</th><th scope=col>Cabin</th><th scope=col>Destination</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Name</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0013_01</td><td>Earth </td><td>True </td><td>G/3/S</td><td>TRAPPIST-1e</td><td>27</td><td>False</td><td> 0</td><td>   0</td><td>  0</td><td>   0</td><td>  0</td><td>Nelly Carsoning </td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0018_01</td><td>Earth </td><td>False</td><td>F/4/S</td><td>TRAPPIST-1e</td><td>19</td><td>False</td><td> 0</td><td>   9</td><td>  0</td><td>2823</td><td>  0</td><td>Lerome Peckers  </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0019_01</td><td>Europa</td><td>True </td><td>C/0/S</td><td>55 Cancri e</td><td>31</td><td>False</td><td> 0</td><td>   0</td><td>  0</td><td>   0</td><td>  0</td><td>Sabih Unhearfus </td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0021_01</td><td>Europa</td><td>False</td><td>C/1/S</td><td>TRAPPIST-1e</td><td>38</td><td>False</td><td> 0</td><td>6652</td><td>  0</td><td> 181</td><td>585</td><td>Meratz Caltilter</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0023_01</td><td>Earth </td><td>False</td><td>F/5/S</td><td>TRAPPIST-1e</td><td>20</td><td>False</td><td>10</td><td>   0</td><td>635</td><td>   0</td><td>  0</td><td>Brence Harperez </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0027_01</td><td>Earth </td><td>False</td><td>F/7/P</td><td>TRAPPIST-1e</td><td>31</td><td>False</td><td> 0</td><td>1615</td><td>263</td><td> 113</td><td> 60</td><td>Karlen Ricks    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 13\n",
       "\\begin{tabular}{r|lllllllllllll}\n",
       "  & PassengerId & HomePlanet & CryoSleep & Cabin & Destination & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Name\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 0013\\_01 & Earth  & True  & G/3/S & TRAPPIST-1e & 27 & False &  0 &    0 &   0 &    0 &   0 & Nelly Carsoning \\\\\n",
       "\t2 & 0018\\_01 & Earth  & False & F/4/S & TRAPPIST-1e & 19 & False &  0 &    9 &   0 & 2823 &   0 & Lerome Peckers  \\\\\n",
       "\t3 & 0019\\_01 & Europa & True  & C/0/S & 55 Cancri e & 31 & False &  0 &    0 &   0 &    0 &   0 & Sabih Unhearfus \\\\\n",
       "\t4 & 0021\\_01 & Europa & False & C/1/S & TRAPPIST-1e & 38 & False &  0 & 6652 &   0 &  181 & 585 & Meratz Caltilter\\\\\n",
       "\t5 & 0023\\_01 & Earth  & False & F/5/S & TRAPPIST-1e & 20 & False & 10 &    0 & 635 &    0 &   0 & Brence Harperez \\\\\n",
       "\t6 & 0027\\_01 & Earth  & False & F/7/P & TRAPPIST-1e & 31 & False &  0 & 1615 & 263 &  113 &  60 & Karlen Ricks    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 13\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | HomePlanet &lt;chr&gt; | CryoSleep &lt;chr&gt; | Cabin &lt;chr&gt; | Destination &lt;chr&gt; | Age &lt;dbl&gt; | VIP &lt;chr&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Name &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0013_01 | Earth  | True  | G/3/S | TRAPPIST-1e | 27 | False |  0 |    0 |   0 |    0 |   0 | Nelly Carsoning  |\n",
       "| 2 | 0018_01 | Earth  | False | F/4/S | TRAPPIST-1e | 19 | False |  0 |    9 |   0 | 2823 |   0 | Lerome Peckers   |\n",
       "| 3 | 0019_01 | Europa | True  | C/0/S | 55 Cancri e | 31 | False |  0 |    0 |   0 |    0 |   0 | Sabih Unhearfus  |\n",
       "| 4 | 0021_01 | Europa | False | C/1/S | TRAPPIST-1e | 38 | False |  0 | 6652 |   0 |  181 | 585 | Meratz Caltilter |\n",
       "| 5 | 0023_01 | Earth  | False | F/5/S | TRAPPIST-1e | 20 | False | 10 |    0 | 635 |    0 |   0 | Brence Harperez  |\n",
       "| 6 | 0027_01 | Earth  | False | F/7/P | TRAPPIST-1e | 31 | False |  0 | 1615 | 263 |  113 |  60 | Karlen Ricks     |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId HomePlanet CryoSleep Cabin Destination Age VIP   RoomService\n",
       "1 0013_01     Earth      True      G/3/S TRAPPIST-1e 27  False  0         \n",
       "2 0018_01     Earth      False     F/4/S TRAPPIST-1e 19  False  0         \n",
       "3 0019_01     Europa     True      C/0/S 55 Cancri e 31  False  0         \n",
       "4 0021_01     Europa     False     C/1/S TRAPPIST-1e 38  False  0         \n",
       "5 0023_01     Earth      False     F/5/S TRAPPIST-1e 20  False 10         \n",
       "6 0027_01     Earth      False     F/7/P TRAPPIST-1e 31  False  0         \n",
       "  FoodCourt ShoppingMall Spa  VRDeck Name            \n",
       "1    0        0             0   0    Nelly Carsoning \n",
       "2    9        0          2823   0    Lerome Peckers  \n",
       "3    0        0             0   0    Sabih Unhearfus \n",
       "4 6652        0           181 585    Meratz Caltilter\n",
       "5    0      635             0   0    Brence Harperez \n",
       "6 1615      263           113  60    Karlen Ricks    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_data <- read.csv(\"/kaggle/input/spaceship-titanic/test.csv\")\n",
    "head(test_data)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f35a579c",
   "metadata": {
    "papermill": {
     "duration": 0.004391,
     "end_time": "2022-12-19T16:46:45.694703",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.690312",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Change data types in test_data\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "ae90f16a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:45.707617Z",
     "iopub.status.busy": "2022-12-19T16:46:45.705598Z",
     "iopub.status.idle": "2022-12-19T16:46:45.803367Z",
     "shell.execute_reply": "2022-12-19T16:46:45.801494Z"
    },
    "papermill": {
     "duration": 0.107137,
     "end_time": "2022-12-19T16:46:45.806008",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.698871",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "test_data <- test_data %>%\n",
    "    select(1:ncol(test_data)) %>%\n",
    "    mutate(\n",
    "        CryoSleep = as.logical(CryoSleep),\n",
    "        Cabin = as.factor(Cabin),\n",
    "        VIP = as.logical(VIP)\n",
    "    )\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "8edaf3ed",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:45.818439Z",
     "iopub.status.busy": "2022-12-19T16:46:45.816732Z",
     "iopub.status.idle": "2022-12-19T16:46:45.840425Z",
     "shell.execute_reply": "2022-12-19T16:46:45.838116Z"
    },
    "papermill": {
     "duration": 0.033227,
     "end_time": "2022-12-19T16:46:45.843474",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.810247",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>PassengerId</dt><dd>'character'</dd><dt>HomePlanet</dt><dd>'character'</dd><dt>CryoSleep</dt><dd>'logical'</dd><dt>Cabin</dt><dd>'factor'</dd><dt>Destination</dt><dd>'character'</dd><dt>Age</dt><dd>'numeric'</dd><dt>VIP</dt><dd>'logical'</dd><dt>RoomService</dt><dd>'numeric'</dd><dt>FoodCourt</dt><dd>'numeric'</dd><dt>ShoppingMall</dt><dd>'numeric'</dd><dt>Spa</dt><dd>'numeric'</dd><dt>VRDeck</dt><dd>'numeric'</dd><dt>Name</dt><dd>'character'</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[PassengerId] 'character'\n",
       "\\item[HomePlanet] 'character'\n",
       "\\item[CryoSleep] 'logical'\n",
       "\\item[Cabin] 'factor'\n",
       "\\item[Destination] 'character'\n",
       "\\item[Age] 'numeric'\n",
       "\\item[VIP] 'logical'\n",
       "\\item[RoomService] 'numeric'\n",
       "\\item[FoodCourt] 'numeric'\n",
       "\\item[ShoppingMall] 'numeric'\n",
       "\\item[Spa] 'numeric'\n",
       "\\item[VRDeck] 'numeric'\n",
       "\\item[Name] 'character'\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "PassengerId\n",
       ":   'character'HomePlanet\n",
       ":   'character'CryoSleep\n",
       ":   'logical'Cabin\n",
       ":   'factor'Destination\n",
       ":   'character'Age\n",
       ":   'numeric'VIP\n",
       ":   'logical'RoomService\n",
       ":   'numeric'FoodCourt\n",
       ":   'numeric'ShoppingMall\n",
       ":   'numeric'Spa\n",
       ":   'numeric'VRDeck\n",
       ":   'numeric'Name\n",
       ":   'character'\n",
       "\n"
      ],
      "text/plain": [
       " PassengerId   HomePlanet    CryoSleep        Cabin  Destination          Age \n",
       " \"character\"  \"character\"    \"logical\"     \"factor\"  \"character\"    \"numeric\" \n",
       "         VIP  RoomService    FoodCourt ShoppingMall          Spa       VRDeck \n",
       "   \"logical\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\" \n",
       "        Name \n",
       " \"character\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(test_data, class)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "9e1bac7b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:45.855793Z",
     "iopub.status.busy": "2022-12-19T16:46:45.854175Z",
     "iopub.status.idle": "2022-12-19T16:46:45.947790Z",
     "shell.execute_reply": "2022-12-19T16:46:45.946054Z"
    },
    "papermill": {
     "duration": 0.102258,
     "end_time": "2022-12-19T16:46:45.950127",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.847869",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>HomePlanet</th><th scope=col>CryoSleep</th><th scope=col>Cabin</th><th scope=col>Destination</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Name</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0001_01</td><td>Europa</td><td>False</td><td>B/0/P</td><td>TRAPPIST-1e  </td><td>39</td><td>False</td><td>  0</td><td>   0</td><td>  0</td><td>   0</td><td>  0</td><td>Maham Ofracculy  </td><td>False</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0002_01</td><td>Earth </td><td>False</td><td>F/0/S</td><td>TRAPPIST-1e  </td><td>24</td><td>False</td><td>109</td><td>   9</td><td> 25</td><td> 549</td><td> 44</td><td>Juanna Vines     </td><td>True </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0003_01</td><td>Europa</td><td>False</td><td>A/0/S</td><td>TRAPPIST-1e  </td><td>58</td><td>True </td><td> 43</td><td>3576</td><td>  0</td><td>6715</td><td> 49</td><td>Altark Susent    </td><td>False</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0003_02</td><td>Europa</td><td>False</td><td>A/0/S</td><td>TRAPPIST-1e  </td><td>33</td><td>False</td><td>  0</td><td>1283</td><td>371</td><td>3329</td><td>193</td><td>Solam Susent     </td><td>False</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0004_01</td><td>Earth </td><td>False</td><td>F/1/S</td><td>TRAPPIST-1e  </td><td>16</td><td>False</td><td>303</td><td>  70</td><td>151</td><td> 565</td><td>  2</td><td>Willy Santantines</td><td>True </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0005_01</td><td>Earth </td><td>False</td><td>F/0/P</td><td>PSO J318.5-22</td><td>44</td><td>False</td><td>  0</td><td> 483</td><td>  0</td><td> 291</td><td>  0</td><td>Sandie Hinetthews</td><td>True </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 14\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & PassengerId & HomePlanet & CryoSleep & Cabin & Destination & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Name & Transported\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 0001\\_01 & Europa & False & B/0/P & TRAPPIST-1e   & 39 & False &   0 &    0 &   0 &    0 &   0 & Maham Ofracculy   & False\\\\\n",
       "\t2 & 0002\\_01 & Earth  & False & F/0/S & TRAPPIST-1e   & 24 & False & 109 &    9 &  25 &  549 &  44 & Juanna Vines      & True \\\\\n",
       "\t3 & 0003\\_01 & Europa & False & A/0/S & TRAPPIST-1e   & 58 & True  &  43 & 3576 &   0 & 6715 &  49 & Altark Susent     & False\\\\\n",
       "\t4 & 0003\\_02 & Europa & False & A/0/S & TRAPPIST-1e   & 33 & False &   0 & 1283 & 371 & 3329 & 193 & Solam Susent      & False\\\\\n",
       "\t5 & 0004\\_01 & Earth  & False & F/1/S & TRAPPIST-1e   & 16 & False & 303 &   70 & 151 &  565 &   2 & Willy Santantines & True \\\\\n",
       "\t6 & 0005\\_01 & Earth  & False & F/0/P & PSO J318.5-22 & 44 & False &   0 &  483 &   0 &  291 &   0 & Sandie Hinetthews & True \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 14\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | HomePlanet &lt;chr&gt; | CryoSleep &lt;chr&gt; | Cabin &lt;chr&gt; | Destination &lt;chr&gt; | Age &lt;dbl&gt; | VIP &lt;chr&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Name &lt;chr&gt; | Transported &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0001_01 | Europa | False | B/0/P | TRAPPIST-1e   | 39 | False |   0 |    0 |   0 |    0 |   0 | Maham Ofracculy   | False |\n",
       "| 2 | 0002_01 | Earth  | False | F/0/S | TRAPPIST-1e   | 24 | False | 109 |    9 |  25 |  549 |  44 | Juanna Vines      | True  |\n",
       "| 3 | 0003_01 | Europa | False | A/0/S | TRAPPIST-1e   | 58 | True  |  43 | 3576 |   0 | 6715 |  49 | Altark Susent     | False |\n",
       "| 4 | 0003_02 | Europa | False | A/0/S | TRAPPIST-1e   | 33 | False |   0 | 1283 | 371 | 3329 | 193 | Solam Susent      | False |\n",
       "| 5 | 0004_01 | Earth  | False | F/1/S | TRAPPIST-1e   | 16 | False | 303 |   70 | 151 |  565 |   2 | Willy Santantines | True  |\n",
       "| 6 | 0005_01 | Earth  | False | F/0/P | PSO J318.5-22 | 44 | False |   0 |  483 |   0 |  291 |   0 | Sandie Hinetthews | True  |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId HomePlanet CryoSleep Cabin Destination   Age VIP   RoomService\n",
       "1 0001_01     Europa     False     B/0/P TRAPPIST-1e   39  False   0        \n",
       "2 0002_01     Earth      False     F/0/S TRAPPIST-1e   24  False 109        \n",
       "3 0003_01     Europa     False     A/0/S TRAPPIST-1e   58  True   43        \n",
       "4 0003_02     Europa     False     A/0/S TRAPPIST-1e   33  False   0        \n",
       "5 0004_01     Earth      False     F/1/S TRAPPIST-1e   16  False 303        \n",
       "6 0005_01     Earth      False     F/0/P PSO J318.5-22 44  False   0        \n",
       "  FoodCourt ShoppingMall Spa  VRDeck Name              Transported\n",
       "1    0        0             0   0    Maham Ofracculy   False      \n",
       "2    9       25           549  44    Juanna Vines      True       \n",
       "3 3576        0          6715  49    Altark Susent     False      \n",
       "4 1283      371          3329 193    Solam Susent      False      \n",
       "5   70      151           565   2    Willy Santantines True       \n",
       "6  483        0           291   0    Sandie Hinetthews True       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data <- read.csv(\"/kaggle/input/spaceship-titanic/train.csv\")\n",
    "head(train_data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "4d530de6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:45.963433Z",
     "iopub.status.busy": "2022-12-19T16:46:45.961878Z",
     "iopub.status.idle": "2022-12-19T16:46:46.033126Z",
     "shell.execute_reply": "2022-12-19T16:46:46.030879Z"
    },
    "papermill": {
     "duration": 0.081458,
     "end_time": "2022-12-19T16:46:46.036322",
     "exception": false,
     "start_time": "2022-12-19T16:46:45.954864",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 3 × 10</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>CryoSleep</th><th scope=col>Cabin</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td> 151</td><td>39</td><td>0</td><td>  0</td><td>   0</td><td> 0</td><td>   0</td><td> 0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>2186</td><td>24</td><td>0</td><td>109</td><td>   9</td><td>25</td><td> 549</td><td>44</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0</td><td>   3</td><td>58</td><td>1</td><td> 43</td><td>3576</td><td> 0</td><td>6715</td><td>49</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 3 × 10\n",
       "\\begin{tabular}{r|llllllllll}\n",
       "  & CryoSleep & Cabin & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Transported\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0 &  151 & 39 & 0 &   0 &    0 &  0 &    0 &  0 & 0\\\\\n",
       "\t2 & 0 & 2186 & 24 & 0 & 109 &    9 & 25 &  549 & 44 & 1\\\\\n",
       "\t3 & 0 &    3 & 58 & 1 &  43 & 3576 &  0 & 6715 & 49 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 3 × 10\n",
       "\n",
       "| <!--/--> | CryoSleep &lt;dbl&gt; | Cabin &lt;dbl&gt; | Age &lt;dbl&gt; | VIP &lt;dbl&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Transported &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 |  151 | 39 | 0 |   0 |    0 |  0 |    0 |  0 | 0 |\n",
       "| 2 | 0 | 2186 | 24 | 0 | 109 |    9 | 25 |  549 | 44 | 1 |\n",
       "| 3 | 0 |    3 | 58 | 1 |  43 | 3576 |  0 | 6715 | 49 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  CryoSleep Cabin Age VIP RoomService FoodCourt ShoppingMall Spa  VRDeck\n",
       "1 0          151  39  0     0            0       0              0  0    \n",
       "2 0         2186  24  0   109            9      25            549 44    \n",
       "3 0            3  58  1    43         3576       0           6715 49    \n",
       "  Transported\n",
       "1 0          \n",
       "2 1          \n",
       "3 0          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data_short <- train_data %>%\n",
    "    select(3:4,6:12,ncol(train_data)) %>%\n",
    "    mutate(\n",
    "        CryoSleep = as.numeric(as.logical(CryoSleep)),\n",
    "        Cabin = as.numeric(as.factor(Cabin)),\n",
    "        VIP = as.numeric(as.logical(VIP)),\n",
    "        Transported = as.numeric(as.logical(Transported))\n",
    "    )\n",
    "head(train_data_short,3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "06a81a09",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:46.049619Z",
     "iopub.status.busy": "2022-12-19T16:46:46.048015Z",
     "iopub.status.idle": "2022-12-19T16:46:46.066016Z",
     "shell.execute_reply": "2022-12-19T16:46:46.064214Z"
    },
    "papermill": {
     "duration": 0.02832,
     "end_time": "2022-12-19T16:46:46.069476",
     "exception": false,
     "start_time": "2022-12-19T16:46:46.041156",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "train_data_short <- train_data_short %>% drop_na() # CryoSleep, VIP, Age\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "d39204e4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:46.085617Z",
     "iopub.status.busy": "2022-12-19T16:46:46.083903Z",
     "iopub.status.idle": "2022-12-19T16:46:46.105877Z",
     "shell.execute_reply": "2022-12-19T16:46:46.103633Z"
    },
    "papermill": {
     "duration": 0.034081,
     "end_time": "2022-12-19T16:46:46.109134",
     "exception": false,
     "start_time": "2022-12-19T16:46:46.075053",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>CryoSleep</dt><dd>'numeric'</dd><dt>Cabin</dt><dd>'numeric'</dd><dt>Age</dt><dd>'numeric'</dd><dt>VIP</dt><dd>'numeric'</dd><dt>RoomService</dt><dd>'numeric'</dd><dt>FoodCourt</dt><dd>'numeric'</dd><dt>ShoppingMall</dt><dd>'numeric'</dd><dt>Spa</dt><dd>'numeric'</dd><dt>VRDeck</dt><dd>'numeric'</dd><dt>Transported</dt><dd>'numeric'</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[CryoSleep] 'numeric'\n",
       "\\item[Cabin] 'numeric'\n",
       "\\item[Age] 'numeric'\n",
       "\\item[VIP] 'numeric'\n",
       "\\item[RoomService] 'numeric'\n",
       "\\item[FoodCourt] 'numeric'\n",
       "\\item[ShoppingMall] 'numeric'\n",
       "\\item[Spa] 'numeric'\n",
       "\\item[VRDeck] 'numeric'\n",
       "\\item[Transported] 'numeric'\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "CryoSleep\n",
       ":   'numeric'Cabin\n",
       ":   'numeric'Age\n",
       ":   'numeric'VIP\n",
       ":   'numeric'RoomService\n",
       ":   'numeric'FoodCourt\n",
       ":   'numeric'ShoppingMall\n",
       ":   'numeric'Spa\n",
       ":   'numeric'VRDeck\n",
       ":   'numeric'Transported\n",
       ":   'numeric'\n",
       "\n"
      ],
      "text/plain": [
       "   CryoSleep        Cabin          Age          VIP  RoomService    FoodCourt \n",
       "   \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\" \n",
       "ShoppingMall          Spa       VRDeck  Transported \n",
       "   \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(train_data_short, class)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "7bcc3ece",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:46.123039Z",
     "iopub.status.busy": "2022-12-19T16:46:46.121401Z",
     "iopub.status.idle": "2022-12-19T16:46:46.151920Z",
     "shell.execute_reply": "2022-12-19T16:46:46.149842Z"
    },
    "papermill": {
     "duration": 0.040829,
     "end_time": "2022-12-19T16:46:46.155008",
     "exception": false,
     "start_time": "2022-12-19T16:46:46.114179",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   CryoSleep          Cabin           Age             VIP         \n",
       " Min.   :0.0000   Min.   :   1   Min.   : 0.00   Min.   :0.00000  \n",
       " 1st Qu.:0.0000   1st Qu.:1160   1st Qu.:19.00   1st Qu.:0.00000  \n",
       " Median :0.0000   Median :3031   Median :27.00   Median :0.00000  \n",
       " Mean   :0.3518   Mean   :3064   Mean   :28.93   Mean   :0.02427  \n",
       " 3rd Qu.:1.0000   3rd Qu.:4837   3rd Qu.:38.00   3rd Qu.:0.00000  \n",
       " Max.   :1.0000   Max.   :6561   Max.   :79.00   Max.   :1.00000  \n",
       "  RoomService        FoodCourt        ShoppingMall          Spa       \n",
       " Min.   :    0.0   Min.   :    0.0   Min.   :    0.0   Min.   :    0  \n",
       " 1st Qu.:    0.0   1st Qu.:    0.0   1st Qu.:    0.0   1st Qu.:    0  \n",
       " Median :    0.0   Median :    0.0   Median :    0.0   Median :    0  \n",
       " Mean   :  225.8   Mean   :  472.7   Mean   :  177.2   Mean   :  318  \n",
       " 3rd Qu.:   49.0   3rd Qu.:   80.0   3rd Qu.:   29.0   3rd Qu.:   65  \n",
       " Max.   :14327.0   Max.   :29813.0   Max.   :23492.0   Max.   :22408  \n",
       "     VRDeck         Transported    \n",
       " Min.   :    0.0   Min.   :0.0000  \n",
       " 1st Qu.:    0.0   1st Qu.:0.0000  \n",
       " Median :    0.0   Median :1.0000  \n",
       " Mean   :  302.5   Mean   :0.5024  \n",
       " 3rd Qu.:   52.0   3rd Qu.:1.0000  \n",
       " Max.   :20336.0   Max.   :1.0000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(train_data_short)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "14daf36f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:46.168939Z",
     "iopub.status.busy": "2022-12-19T16:46:46.167365Z",
     "iopub.status.idle": "2022-12-19T16:46:46.190334Z",
     "shell.execute_reply": "2022-12-19T16:46:46.188542Z"
    },
    "papermill": {
     "duration": 0.032578,
     "end_time": "2022-12-19T16:46:46.192908",
     "exception": false,
     "start_time": "2022-12-19T16:46:46.160330",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>CryoSleep</dt><dd>0.477569081756416</dd><dt>Cabin</dt><dd>2011.28136384897</dd><dt>Age</dt><dd>14.4840122735348</dd><dt>VIP</dt><dd>0.15390459987841</dd><dt>RoomService</dt><dd>667.393693398722</dd><dt>FoodCourt</dt><dd>1645.32902251256</dd><dt>ShoppingMall</dt><dd>623.515688561467</dd><dt>Spa</dt><dd>1166.01421295028</dd><dt>VRDeck</dt><dd>1115.45356510241</dd><dt>Transported</dt><dd>0.500028656343819</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[CryoSleep] 0.477569081756416\n",
       "\\item[Cabin] 2011.28136384897\n",
       "\\item[Age] 14.4840122735348\n",
       "\\item[VIP] 0.15390459987841\n",
       "\\item[RoomService] 667.393693398722\n",
       "\\item[FoodCourt] 1645.32902251256\n",
       "\\item[ShoppingMall] 623.515688561467\n",
       "\\item[Spa] 1166.01421295028\n",
       "\\item[VRDeck] 1115.45356510241\n",
       "\\item[Transported] 0.500028656343819\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "CryoSleep\n",
       ":   0.477569081756416Cabin\n",
       ":   2011.28136384897Age\n",
       ":   14.4840122735348VIP\n",
       ":   0.15390459987841RoomService\n",
       ":   667.393693398722FoodCourt\n",
       ":   1645.32902251256ShoppingMall\n",
       ":   623.515688561467Spa\n",
       ":   1166.01421295028VRDeck\n",
       ":   1115.45356510241Transported\n",
       ":   0.500028656343819\n",
       "\n"
      ],
      "text/plain": [
       "   CryoSleep        Cabin          Age          VIP  RoomService    FoodCourt \n",
       "   0.4775691 2011.2813638   14.4840123    0.1539046  667.3936934 1645.3290225 \n",
       "ShoppingMall          Spa       VRDeck  Transported \n",
       " 623.5156886 1166.0142130 1115.4535651    0.5000287 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(train_data_short, sd)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "02d835f4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T16:46:46.209569Z",
     "iopub.status.busy": "2022-12-19T16:46:46.207944Z",
     "iopub.status.idle": "2022-12-19T16:46:46.277980Z",
     "shell.execute_reply": "2022-12-19T16:46:46.276224Z"
    },
    "papermill": {
     "duration": 0.08187,
     "end_time": "2022-12-19T16:46:46.280570",
     "exception": false,
     "start_time": "2022-12-19T16:46:46.198700",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.818502548020384"
      ],
      "text/latex": [
       "0.818502548020384"
      ],
      "text/markdown": [
       "0.818502548020384"
      ],
      "text/plain": [
       "[1] 0.8185025"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "cryo_sleep <- train_data_short %>%\n",
    "    filter(train_data_short$CryoSleep == TRUE) %>%\n",
    "    select(Transported)\n",
    "\n",
    "percent_cryo_transported <- sum(cryo_sleep$Transported, na.rm=TRUE) / nrow(cryo_sleep)\n",
    "percent_cryo_transported"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.101953,
   "end_time": "2022-12-19T16:46:46.408114",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-12-19T16:46:40.306161",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
