# Julia wrapper for header: /usr/include/scip/scip_dialog.h
# Automatically generated using Clang.jl wrap_c, version 0.0.0


function SCIPincludeDialog(scip, dialog, dialogcopy, dialogexec, dialogdesc, dialogfree, name, desc, issubmenu::UInt32, dialogdata)
    ccall((:SCIPincludeDialog, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{Ptr{SCIP_DIALOG}}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cstring, UInt32, Ptr{SCIP_DIALOGDATA}), scip, dialog, dialogcopy, dialogexec, dialogdesc, dialogfree, name, desc, issubmenu, dialogdata)
end

function SCIPexistsDialog(scip, dialog)
    ccall((:SCIPexistsDialog, libscip), UInt32, (Ptr{SCIP}, Ptr{SCIP_DIALOG}), scip, dialog)
end

function SCIPcaptureDialog(scip, dialog)
    ccall((:SCIPcaptureDialog, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{SCIP_DIALOG}), scip, dialog)
end

function SCIPreleaseDialog(scip, dialog)
    ccall((:SCIPreleaseDialog, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{Ptr{SCIP_DIALOG}}), scip, dialog)
end

function SCIPsetRootDialog(scip, dialog)
    ccall((:SCIPsetRootDialog, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{SCIP_DIALOG}), scip, dialog)
end

function SCIPgetRootDialog(scip)
    ccall((:SCIPgetRootDialog, libscip), Ptr{SCIP_DIALOG}, (Ptr{SCIP},), scip)
end

function SCIPaddDialogEntry(scip, dialog, subdialog)
    ccall((:SCIPaddDialogEntry, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{SCIP_DIALOG}, Ptr{SCIP_DIALOG}), scip, dialog, subdialog)
end

function SCIPaddDialogInputLine(scip, inputline)
    ccall((:SCIPaddDialogInputLine, libscip), SCIP_RETCODE, (Ptr{SCIP}, Cstring), scip, inputline)
end

function SCIPaddDialogHistoryLine(scip, inputline)
    ccall((:SCIPaddDialogHistoryLine, libscip), SCIP_RETCODE, (Ptr{SCIP}, Cstring), scip, inputline)
end

function SCIPstartInteraction(scip)
    ccall((:SCIPstartInteraction, libscip), SCIP_RETCODE, (Ptr{SCIP},), scip)
end
