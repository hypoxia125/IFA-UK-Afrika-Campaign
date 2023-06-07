// Mission
#undef TAG
#define TAG                                         "IFA_UK_DES_"

// Macros
#undef GMVAR
#define GMVAR(var1,var2)                            missionNamespace getVariable [var1,var2]

#undef SETMVAR
#define SETMVAR(var1,var2,var3)                     missionNamespace setVariable [var1,var2,var3]

// UI
#define LAYER_BLACKSCREEN                           "hyp_blackscreen"

// Common
#define SERVERINITDONE                              "hyp_server"
#define MISSIONSTARTED                              "hyp_missionStarted"

// Triggers
#define TRIGGER_TICKRATE_DEFAULT                    sleep 0.5