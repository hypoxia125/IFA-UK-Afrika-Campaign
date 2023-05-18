class CfgSentences
{
	class IFA_UK_DES_M01
	{
		class intro
		{
			file = "kb\intro.bikb";
			class Sentences
            {
                class intro_1
                {
                    name = "IFA_UK_DES_M01_Intro_Miller_01";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_INTRO_MILLER_01";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Intro_Miller_01.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };

                class intro_2
                {
                    name = "IFA_UK_DES_M01_Intro_Miller_02";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_INTRO_MILLER_02";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Intro_Miller_02.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };

                class intro_3
                {
                    name = "IFA_UK_DES_M01_Intro_Miller_03";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_INTRO_MILLER_03";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Intro_Miller_03.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };

                class intro_4
                {
                    name = "IFA_UK_DES_M01_Intro_Miller_04";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_INTRO_MILLER_04";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Intro_Miller_04.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };
            };

            class Arguments {};
            class Special {};
            startWithVocal[] = { "hour" };
            startWithConsonant[] = { "europe", "university" };
		};

		class observe
		{
			file = "kb\observe.bikb";
            class Sentences
            {
                class observe_1
                {
                    name = "IFA_UK_DES_M01_Observe_Miller_01";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_OBSERVE_MILLER_01";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Observe_Miller_01.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };
            };

            // Needed parameters.
            class Arguments {};
            class Special {};
            startWithVocal[] = { "hour" };
            startWithConsonant[] = { "europe", "university" };
		};

		class destroy
		{
			file = "kb\destroy.bikb";
            class Sentences
            {
                class destroy_1
                {
                    name = "IFA_UK_DES_M01_Destroy_Miller_01";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_DESTROY_MILLER_01";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Destroy_Miller_01.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };

                class destroy_2
                {
                    name = "IFA_UK_DES_M01_Destroy_Miller_02";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_DESTROY_MILLER_02";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Destroy_Miller_02.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };

                class destroy_3
                {
                    name = "IFA_UK_DES_M01_Destroy_Miller_03";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_DESTROY_MILLER_03";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Destroy_Miller_03.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };
            };

            // Needed parameters.
            class Arguments {};
            class Special {};
            startWithVocal[] = { "hour" };
            startWithConsonant[] = { "europe", "university" };
		};

		class escape
		{
			file = "kb\escape.bikb";
            class Sentences
            {
                class Escape_1
                {
                    name = "IFA_UK_DES_M01_Escape_Miller_01";
                    text = "$STR_IFA_UK_DES_M01_SPEECH_Escape_MILLER_01";
                    speech[] = {"\data\voice\M01\IFA_UK_DES_M01_Escape_Miller_01.ogg"};
                    class Arguments {};

                    actor = "HQ";
                };
            };

            // Needed parameters.
            class Arguments {};
            class Special {};
            startWithVocal[] = { "hour" };
            startWithConsonant[] = { "europe", "university" };
		};
	};
};