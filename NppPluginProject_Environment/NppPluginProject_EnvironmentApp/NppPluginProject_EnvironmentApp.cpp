// NppPluginPROJECT_CHOOSERApp.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "resource.h"
#include "PluginInterface.h"

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;								// current instance
TCHAR szTitle[MAX_LOADSTRING];					// The title bar text
TCHAR szWindowClass[MAX_LOADSTRING];			// the main window class name
HMODULE hMod;
int nbfunc;
FuncItem *pfunclst;

// Forward declarations of functions included in this code module:
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int, LPTSTR);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK	About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY _tWinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPTSTR    lpCmdLine,
    _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.
    MSG msg;
    HACCEL hAccelTable;

    // Initialize global strings
    LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadString(hInstance, IDC_NPPPLUGINPROJECT_ENVIRONMENTAPP, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if(!InitInstance(hInstance, nCmdShow, lpCmdLine))
    {
        return 1;
    }

    hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_NPPPLUGINPROJECT_ENVIRONMENTAPP));

    // Main message loop:
    while(GetMessage(&msg, NULL, 0, 0))
    {
        if(!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int)msg.wParam;
}

//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEX wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc = WndProc;
    wcex.cbClsExtra = 0;
    wcex.cbWndExtra = 0;
    wcex.hInstance = hInstance;
    wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_NPPPLUGINPROJECT_CHOOSERAPP));
    wcex.hCursor = LoadCursor(NULL, IDC_ARROW);
    wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wcex.lpszMenuName = MAKEINTRESOURCE(IDC_NPPPLUGINPROJECT_ENVIRONMENTAPP);
    wcex.lpszClassName = szWindowClass;
    wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassEx(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow, LPTSTR lpCmdLine)
{
    HWND hWnd;

    hInst = hInstance; // Store instance handle in our global variable

    hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

    if(!hWnd)
    {
        return FALSE;
    }

    hMod = LoadLibrary(lpCmdLine);
    if(NULL == hMod)
    {
        MessageBox(
            NULL,
            lpCmdLine,
            (LPCWSTR)L"Failed to load:",
            MB_OK
            );

        return 1;
    }

    FARPROC pfunc = GetProcAddress(hMod, "setInfo");
    if(NULL == hMod)
    {
        return 1;
    }

    typedef void(*FUNCINFO)(NppData);

    FUNCINFO pfuncinfo = (FUNCINFO)pfunc;

    NppData nppdata = { hWnd, 0, 0 };

    pfuncinfo(nppdata);

    pfunc = GetProcAddress(hMod, "getFuncsArray");
    if(NULL == hMod)
    {
        return 1;
    }

    typedef FuncItem *(*FUNCITEM)(int *);

    FUNCITEM pfuncitem = (FUNCITEM)pfunc;

    pfunclst = pfuncitem(&nbfunc);

    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);

    return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE:  Processes messages for the main window.
//
//  WM_COMMAND	- process the application menu
//  WM_PAINT	- Paint the main window
//  WM_DESTROY	- post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    int wmId, wmEvent;
    PAINTSTRUCT ps;
    HDC hdc;

    switch(message)
    {
    case WM_COMMAND:
        wmId = LOWORD(wParam);
        wmEvent = HIWORD(wParam);
        // Parse the menu selections:
        switch(wmId)
        {
        case IDM_ABOUT:
            DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
            break;
        case IDM_EXIT:
            DestroyWindow(hWnd);
            break;
        case IDM_PROJECT:
            pfunclst[0]._pFunc();
            break;
        case IDM_TOOLS:
            pfunclst[1]._pFunc();
            break;
        case IDM_TEST:
            pfunclst[2]._pFunc();
            break;
        case IDM_TEST_ISSUE:
            pfunclst[3]._pFunc();
            break;
        case IDM_SKYVIPER:
            pfunclst[4]._pFunc();
            break;
        case IDM_SKYVIPER_CONFIG:
            pfunclst[5]._pFunc();
            break;
        case IDM_SKYVIPER_BUILD:
            pfunclst[6]._pFunc();
            break;
        case IDM_SKYVIPER_ISSUE:
            pfunclst[7]._pFunc();
            break;
        case IDM_RECOIL:
            pfunclst[8]._pFunc();
            break;
        case IDM_MEBO2:
            pfunclst[9]._pFunc();
            break;
        case IDM_MEBO2_CONFIG:
            pfunclst[10]._pFunc();
            break;
        case IDM_MEBO2_BUILD:
            pfunclst[11]._pFunc();
            break;
        case IDM_MEBO2_ISSUE:
            pfunclst[12]._pFunc();
            break;
        case IDM_GRUMBLIES:
            pfunclst[13]._pFunc();
            break;
        case IDM_GRUMBLIES_CONFIG:
            pfunclst[14]._pFunc();
            break;
        case IDM_GRUMBLIES_ISSUE:
            pfunclst[15]._pFunc();
            break;
        case IDM_POMSIES:
            pfunclst[16]._pFunc();
            break;
        case IDM_POMSIES_CONFIG:
            pfunclst[17]._pFunc();
            break;
        case IDM_POMSIES_ISSUE:
            pfunclst[18]._pFunc();
            break;
        case IDM_SKYVIPERGPS:
            pfunclst[19]._pFunc();
            break;
        case IDM_SKYVIPERGPS_CONFIG:
            pfunclst[20]._pFunc();
            break;
        case IDM_SKYVIPERGPS_BUILD:
            pfunclst[21]._pFunc();
            break;
        case IDM_SKYVIPERGPS_ISSUE:
            pfunclst[22]._pFunc();
            break;
        default:
            return DefWindowProc(hWnd, message, wParam, lParam);
        }
        break;
    case WM_PAINT:
        hdc = BeginPaint(hWnd, &ps);
        // TODO: Add any drawing code here...
        EndPaint(hWnd, &ps);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    case NPPM_DMMSHOW:
        ::ShowWindow((HWND)lParam, true);
        break;
    case NPPM_DMMHIDE:
        ::ShowWindow((HWND)lParam, false);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch(message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if(LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}
