#pragma once
#include "vDrawableComponent.h"

using namespace vEngine;
namespace Rendering {
	class TriangleDemo : public DrawableComponent {
		RTTI_DECLARATIONS(TriangleDemo, DrawableComponent)
	public:
		TriangleDemo(Engine& game, Camera& camera);
		virtual ~TriangleDemo();
	private:
		TriangleDemo();
		TriangleDemo(const TriangleDemo& rhs);
		TriangleDemo& operator=(const TriangleDemo& rhs);
	public:
		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;
	private:
		typedef struct _BasicEffectVertex
		{
			XMFLOAT4 Position;
			XMFLOAT4 Color;
			_BasicEffectVertex() { }
			_BasicEffectVertex(XMFLOAT4 position, XMFLOAT4 color)
				: Position(position), Color(color) { }
		} BasicEffectVertex;
	private:
		ID3DX11Effect* mEffect;
		ID3DX11EffectTechnique* mTechnique;
		ID3DX11EffectPass* mPass;
		ID3DX11EffectMatrixVariable* mWvpVariable;
		ID3D11InputLayout* mInputLayout;
		ID3D11Buffer* mVertexBuffer;
		XMFLOAT4X4 mWorldMatrix;
		float mAngle;
	};
}