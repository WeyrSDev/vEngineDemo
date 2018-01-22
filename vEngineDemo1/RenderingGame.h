#pragma once

#include "vInclude.h"
#include "vEngine.h"

using namespace vEngine;

namespace vEngine {
	class Keyboard;
	class Mouse;
	class FPSCamera;
	class FpsCounter;
	class RenderStateHelper;
	class Grid;
}

namespace Rendering {
	class DiffuseLightingDemo;
	class RenderingGame : public Engine
	{
	public:
		RenderingGame(HINSTANCE instance, const std::wstring& windowClass, const std::wstring& windowTitle, int showCommand);
		~RenderingGame();
	public:
		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;
	protected:
		virtual void Shutdown() override;
	private:
		static const XMVECTORF32 BackgroundColor;
	private:
		LPDIRECTINPUT8 mDirectInput;
		Keyboard* mKeyboard;
		Mouse* mMouse;
		FPSCamera* mCamera;
		FpsCounter* mFpsComponent;
		RenderStateHelper* mRenderStateHelper;
		Grid* mGrid;
		DiffuseLightingDemo* mDiffuseLightingDemo;
	};
}