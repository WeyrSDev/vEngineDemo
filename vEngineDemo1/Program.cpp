﻿#include <memory>
#include "vException.h"
#include "RenderingGame.h"

#if defined(DEBUG) || defined(_DEBUG)
#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#endif

using namespace vEngine;
using namespace Rendering;

int WINAPI WinMain(HINSTANCE instance, HINSTANCE previousInstance, LPSTR commandLine, int showCommand)
{
#if defined(DEBUG) | defined(_DEBUG)
    _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
#endif

    std::unique_ptr<RenderingGame> game(new RenderingGame(instance, L"EngineClass", L"GameName", showCommand));

    try
    {
        game->Run();
    }
    catch (Exception ex)
    {
        MessageBox(game->WindowHandle(), ex.whatw().c_str(), game->WindowTitle().c_str(), MB_ABORTRETRYIGNORE);
    }

    return 0;
}